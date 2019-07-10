package controllers

import (
	"fmt"
	"sec-officer_api/include"
	"sec-officer_api/models"
	"strconv"

	jwt "github.com/appleboy/gin-jwt/v2"
	"github.com/astaxie/beego/validation"
	"github.com/gin-gonic/gin"
	"golang.org/x/crypto/bcrypt"
)

type User = models.User
type Role = models.Role

// Data is mainle generated for filtering and pagination
type DataUser struct {
	Total int64  `json:"total"`
	Data  []User `json:"data"`
}

func hash(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), 12)
	return string(bytes), err
}

func GetUser(c *gin.Context) {
	db = include.GetDB()
	id := c.Params.ByName("id")
	var user User
	var role Role

	if err := db.Where("id = ? ", id).First(&user).Error; err != nil {

		c.AbortWithStatus(404)
		fmt.Println(err)

	} else {

		db.Model(&user).Related(&role)
		// SELECT * FROM "tags"  WHERE ("post_id" = 1)

		user.Role = role
		c.JSON(200, user)
	}
}

func GetUsers(c *gin.Context) {
	db = include.GetDB()
	var users []User
	var data DataUser
	var count int64

	// //Get name from query
	// name := c.DefaultQuery("name", "")

	// //Get description from query
	// description := c.DefaultQuery("description", "")

	// // Order By filtering option add
	// Sort := c.DefaultQuery("order", "id|desc")
	// SortArray := strings.Split(Sort, "|")

	// Define and get offset for pagination
	offset := c.Query("offset")
	offsetInt, err := strconv.Atoi(offset)
	if err != nil {
		offsetInt = 0
	}

	// Define and get limit for pagination
	limit := c.Query("limit")
	limitInt, err := strconv.Atoi(limit)
	if err != nil {
		limitInt = 25
	}

	query := db.Set("gorm:auto_preload", true).Limit(limitInt)
	query = query.Offset(offsetInt)
	// query = query.Order(SortArray[0] + " " + SortArray[1])

	// // In postgres you shoud use ILIKE to make search case insensitive
	// if name != "" {
	// 	query = query.Where("name LIKE ?", "%"+name+"%")
	// }

	// if description != "" {
	// 	query = query.Where("description LIKE ?", "%"+description+"%")
	// }

	if err := query.Find(&users).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {

		// We are resetting offset to 0 to return total number.
		// This is a fix for Gorm offset issue
		offsetInt = 0
		query = query.Offset(offsetInt)
		query.Table("users").Count(&count)

		data.Total = count
		data.Data = users

		c.JSON(200, data)
	}
}

func CreateUser(c *gin.Context) {
	db = include.GetDB()
	claims := jwt.ExtractClaims(c)

	var user User

	c.BindJSON(&user)

	valid := validation.Validation{}
	valid.Required(&user.Username, "username").Message("username is required")
	valid.Required(&user.Password, "password").Message("password is required")
	valid.Required(&user.FirstName, "first_name").Message("first_name is required")
	valid.Required(&user.LastName, "last_name").Message("last_name is required")
	valid.Min(&user.RoleID, 1, "role_id").Message("role_id is required")
	valid.Min(&user.CourtID, 1, "court_id").Message("court_id is required")

	if !valid.HasErrors() {

		hashPassword, _ := hash(user.Password)
		user.Password = hashPassword

		user.CreatedUid = int(claims["id"].(float64))

		if err := db.Create(&user).Error; err != nil {
			c.JSON(404, gin.H{
				"message": err.Error(),
			})
			fmt.Println(err)
		} else {
			c.JSON(200, user)
		}
	} else {
		c.JSON(400, valid.Errors)
	}

}

func UpdateUser(c *gin.Context) {
	db = include.GetDB()
	claims := jwt.ExtractClaims(c)

	var user User
	id := c.Params.ByName("id")

	if err := db.Where("id = ?", id).First(&user).Error; err != nil {
		c.JSON(404, gin.H{
			"message": err.Error(),
		})
		fmt.Println(err)
		return
	}

	password_old := user.Password

	c.BindJSON(&user)

	if user.Password != password_old {
		hashPassword, _ := hash(user.Password)
		user.Password = hashPassword
	}

	user.UpdatedUid = int(claims["id"].(float64))

	if err := db.Save(&user).Error; err != nil {
		c.JSON(404, gin.H{
			"message": err.Error(),
		})
		fmt.Println(err)
	} else {
		c.JSON(200, user)
	}
}
