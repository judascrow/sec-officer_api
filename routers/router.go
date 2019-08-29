package routers

import (
	"log"
	"sec-officer_api/controllers"

	jwt "github.com/appleboy/gin-jwt/v2"
	"github.com/gin-contrib/static"
	"github.com/gin-gonic/gin"
)

func ApplyRoutes(router *gin.Engine) {

	authMiddleware := AuthMiddlewareJWT()

	router.NoRoute(authMiddleware.MiddlewareFunc(), func(c *gin.Context) {
		claims := jwt.ExtractClaims(c)
		log.Printf("NoRoute claims: %#v\n", claims)
		c.JSON(404, gin.H{"code": "PAGE_NOT_FOUND", "message": "Page not found"})
	})

	apiv1 := router.Group("/api/v1")
	apiv1.POST("/login", authMiddleware.LoginHandler)

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
		users.GET("/", controllers.GetUsers)
		users.GET("/:id", controllers.GetUser)
		users.POST("/", controllers.CreateUser)
		users.PUT("/:id", controllers.UpdateUser)
		users.DELETE("/:id", controllers.DeleteUser)
	}

	courts := apiv1.Group("/courts")
	courts.Use(authMiddleware.MiddlewareFunc())
	{
		courts.GET("/", controllers.GetCourts)
	}

	secPersons := apiv1.Group("/sec_persons")
	secPersons.Use(authMiddleware.MiddlewareFunc())
	{
		secPersons.GET("/", controllers.GetSecPersons)
		secPersons.GET("/:id", controllers.GetSecPerson)
		secPersons.POST("/", controllers.CreateSecPerson)
		secPersons.PUT("/:id", controllers.UpdateSecPerson)
		secPersons.DELETE("/:id", controllers.DeleteSecPerson)
	}

	courtReport := apiv1.Group("/court_reports")
	courtReport.Use(authMiddleware.MiddlewareFunc())
	{
		courtReport.GET("/", controllers.GetCourtReports)
		courtReport.GET("/:id", controllers.GetCourtReport)
		courtReport.POST("/", controllers.CreateCourtReport)
		courtReport.PUT("/:id", controllers.UpdateCourtReport)
		courtReport.DELETE("/:id", controllers.DeleteCourtReport)
		courtReport.PATCH("/:id", controllers.UploadFile)
	}

	adminReport := apiv1.Group("/admin_reports")
	adminReport.Use(authMiddleware.MiddlewareFunc())
	{
		adminReport.GET("/", controllers.GetAdminReport)
		adminReport.PATCH("/accept/:id", controllers.AcceptReport)
		adminReport.PATCH("/unaccept/:id", controllers.UnAcceptReport)
	}

	router.Use(static.Serve("/files", static.LocalFile("uploads/", true)))

	dashboard := apiv1.Group("/dashboard")
	{
		dashboard.GET("/total_court", controllers.GetTotalCourt)
		dashboard.GET("/total_court_report", controllers.GetTotalCourtReport)
		dashboard.GET("/total_sec", controllers.GetTotalSec)
		dashboard.GET("/total_sec_work", controllers.GetTotalWork)
		dashboard.GET("/bar", controllers.GetArrayDepart)
		dashboard.GET("/donut", controllers.GetTotalWork2)
	}
}
