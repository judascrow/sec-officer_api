package main

import (
	"sec-officer_api/config"
	"sec-officer_api/include"
	"sec-officer_api/models"
	"sec-officer_api/routers"

	"sec-officer_api/middleware"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

var db *gorm.DB

func main() {
	config := config.InitConfig()

	db = include.InitDB()
	defer db.Close()
	db.AutoMigrate(&models.Post{}, &models.Tag{}, &models.User{}, &models.Role{}, &models.Court{})

	app := gin.Default()
	app.Use(middleware.CORS())

	routers.ApplyRoutes(app)
	app.Run(":" + config.Server.Port)
}
