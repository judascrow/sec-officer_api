package main

import (
	"log"
	"sec-officer_api/config"
	"sec-officer_api/controllers"
	"sec-officer_api/include"
	"sec-officer_api/middleware"
	"sec-officer_api/models"
	"time"

	jwt "github.com/appleboy/gin-jwt/v2"
	"github.com/casbin/casbin"
	gormadapter "github.com/casbin/gorm-adapter"
	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
	"golang.org/x/crypto/bcrypt"
)

var db *gorm.DB
var casbinEnforcer *casbin.Enforcer
var err error

type login struct {
	Username string `form:"username" json:"username" binding:"required"`
	Password string `form:"password" json:"password" binding:"required"`
}

// User struct alias
type User = models.User

var identityKey = "id"
var identityUsername = "username"
var identityRole = "role_id"

func main() {
	config := config.InitConfig()

	db = include.InitDB()
	defer db.Close()
	db.AutoMigrate(&models.Post{}, &models.Tag{}, &models.User{}, &models.Role{})

	driver := config.Database.Driver
	database := config.Database.Dbname
	username := config.Database.Username
	password := config.Database.Password
	host := config.Database.Host
	port := config.Database.Port
	pg_conn_info := username + ":" + password + "@tcp(" + host + ":" + port + ")/" + database + "?charset=utf8&parseTime=True&loc=Local"
	casbin_adapter := gormadapter.NewAdapter(driver, pg_conn_info, true)
	e := casbin.NewEnforcer("./auth.conf", casbin_adapter)
	casbinEnforcer = e
	e.LoadPolicy()

	router := gin.Default()
	router.Use(middleware.CORS())

	authMiddleware, err := jwt.New(&jwt.GinJWTMiddleware{
		Realm:       "test zone",
		Key:         []byte("secret key"),
		Timeout:     time.Hour,
		MaxRefresh:  time.Hour,
		IdentityKey: identityKey,
		PayloadFunc: func(data interface{}) jwt.MapClaims {
			if v, ok := data.(*User); ok {
				return jwt.MapClaims{
					identityKey:      v.ID,
					identityUsername: v.Username,
					identityRole:     v.RoleID,
				}
			}
			return jwt.MapClaims{}
		},
		IdentityHandler: func(c *gin.Context) interface{} {
			claims := jwt.ExtractClaims(c)
			return &User{
				ID:       uint(claims["id"].(float64)),
				Username: claims["username"].(string),
				RoleID:   int(claims["role_id"].(float64)),
			}
		},
		Authenticator: func(c *gin.Context) (interface{}, error) {
			var loginVals login
			if err := c.ShouldBind(&loginVals); err != nil {
				return "", jwt.ErrMissingLoginValues
			}
			username := loginVals.Username
			password := loginVals.Password

			var user User
			if err := db.Where("username = ?", username).First(&user).Error; err != nil {
				return nil, jwt.ErrFailedAuthentication
			}

			if checkHash(password, user.Password) {
				return &User{
					ID:        user.ID,
					Username:  user.Username,
					FirstName: user.FirstName,
					LastName:  user.LastName,
					RoleID:    user.RoleID,
				}, nil
			}

			return nil, jwt.ErrFailedAuthentication
		},
		Authorizator: func(data interface{}, c *gin.Context) bool {
			if v, ok := data.(*User); ok && v.Username != "" {
				return casbinEnforcer.Enforce(v.Username, c.Request.URL.String(), c.Request.Method)
			}

			return false
		},
		Unauthorized: func(c *gin.Context, code int, message string) {
			c.JSON(code, gin.H{
				"code":    code,
				"message": message,
			})
		},
		// TokenLookup is a string in the form of "<source>:<name>" that is used
		// to extract token from the request.
		// Optional. Default value "header:Authorization".
		// Possible values:
		// - "header:<name>"
		// - "query:<name>"
		// - "cookie:<name>"
		// - "param:<name>"
		TokenLookup: "header: Authorization, query: token, cookie: jwt",
		// TokenLookup: "query:token",
		// TokenLookup: "cookie:token",

		// TokenHeadName is a string in the header. Default value is "Bearer"
		TokenHeadName: "Bearer",

		// TimeFunc provides the current time. You can override it to use another time value. This is useful for testing or if your server uses a different time zone than your tokens.
		TimeFunc: time.Now,
	})

	if err != nil {
		log.Fatal("JWT Error:" + err.Error())
	}

	apiv1 := router.Group("/api/v1")

	apiv1.POST("/login", authMiddleware.LoginHandler)

	router.NoRoute(authMiddleware.MiddlewareFunc(), func(c *gin.Context) {
		claims := jwt.ExtractClaims(c)
		log.Printf("NoRoute claims: %#v\n", claims)
		c.JSON(404, gin.H{"code": "PAGE_NOT_FOUND", "message": "Page not found"})
	})

	auth := apiv1.Group("/me")
	auth.Use(authMiddleware.MiddlewareFunc())
	{
		auth.GET("/", helloHandler)
	}

	posts := apiv1.Group("/posts")
	posts.Use(authMiddleware.MiddlewareFunc())
	{
		posts.GET("/", controllers.GetPosts)
		posts.GET("/:id", controllers.GetPost)
		posts.POST("/", controllers.CreatePost)
		posts.PUT("/:id", controllers.UpdatePost)
		posts.DELETE("/:id", controllers.DeletePost)
	}

	users := apiv1.Group("/users")
	users.Use(authMiddleware.MiddlewareFunc())
	{
		// users.GET("/", controllers.GetPosts)
		users.GET("/:id", controllers.GetUser)
		users.POST("/", controllers.CreateUser)
		// users.PUT("/:id", controllers.UpdatePost)
		// users.DELETE("/:id", controllers.DeletePost)
	}

	router.Run(":" + config.Server.Port)
}

func checkHash(password string, hash string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))
	return err == nil
}

func helloHandler(c *gin.Context) {
	claims := jwt.ExtractClaims(c)
	user, _ := c.Get(identityKey)
	c.JSON(200, gin.H{
		"userID":   claims["id"],
		"username": user.(*User).Username,
		"roleID":   user.(*User).RoleID,
	})
}
