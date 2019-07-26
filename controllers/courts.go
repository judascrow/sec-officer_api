package controllers

import (
	"fmt"
	"sec-officer_api/include"
	"sec-officer_api/models"

	"github.com/gin-gonic/gin"
)

type Court = models.Court

// Data is mainle generated for filtering and pagination
type DataCourt struct {
	Total int64   `json:"total"`
	Data  []Court `json:"data"`
}

func GetCourts(c *gin.Context) {
	db = include.GetDB()
	var courts []Court
	var data DataCourt
	var count int64

	if err := db.Find(&courts).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {

		db.Find(&courts).Count(&count)

		data.Total = count
		data.Data = courts

		c.JSON(200, data)
	}
}
