package controllers

import (
	"fmt"
	"sec-officer_api/include"
	"sec-officer_api/models"

	jwt "github.com/appleboy/gin-jwt/v2"
	"github.com/astaxie/beego/validation"
	"github.com/gin-gonic/gin"
)

// CourtReport Model
type CourtReport = models.CourtReport

// DataCourtReport Model
type DataCourtReport struct {
	Total int64        `json:"total"`
	Data  []CourtReport `json:"data"`
}

// GetCourtReports function
func GetCourtReports(c *gin.Context) {
	db = include.GetDB()
	var courtReports []CourtReport
	var data DataCourtReport
	var count int64

	claims := jwt.ExtractClaims(c)
	userCourtID := 0
	if claims["court_id"] != nil {
		userCourtID = int(claims["court_id"].(float64))
	}

	query := db.Set("gorm:auto_preload", true).Where("court_id = ?", userCourtID).Order("year desc, month desc")

	if err := query.Find(&courtReports).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {

		query.Find(&courtReports).Count(&count)

		data.Total = count
		data.Data = courtReports

		c.JSON(200, data)
	}
}

// CreateCourtReport function
func CreateCourtReport(c *gin.Context) {
	db = include.GetDB()
	claims := jwt.ExtractClaims(c)

	var courtReport CourtReport

	err := c.BindJSON(&courtReport)
	if err != nil {
		c.JSON(400, err)
	}

	valid := validation.Validation{}
	valid.Required(&courtReport.Year, "year").Message("Year is required")
	valid.Required(&courtReport.Month, "month").Message("Month is required")
	// valid.Required(&courtReport.Work7Day, "work_7day").Message("work_7day is required")
	// valid.Required(&courtReport.Work6Day, "work_6day").Message("work_6day is required")
	// valid.Required(&courtReport.TotalShuffle, "total_shuffle").Message("total_shuffle is required")
	// valid.Required(&courtReport.TotalShuffleExcept, "total_shuffle_except").Message("total_shuffle_except is required")
	// valid.Required(&courtReport.TotalShuffleAbsence, "total_shuffle_Absence").Message("total_shuffle_Absence is required")
	// valid.Required(&courtReport.ReporterName, "reporter_name").Message("reporter_name is required")
	// valid.Required(&courtReport.ReporterPosition, "reporter_position").Message("reporter_position is required")
	// valid.Required(&courtReport.InspectorName, "inspector_name").Message("inspector_name is required")
	// valid.Required(&courtReport.InspectorPosition, "inspector_position").Message("inspector_position is required")

	if !valid.HasErrors() {

		if claims["court_id"] != nil {
			courtReport.CourtID = int(claims["court_id"].(float64))
		}

		if err := db.Where("court_id = ? AND year = ? AND month = ?", &courtReport.CourtID, &courtReport.Year, &courtReport.Month).First(&courtReport).Error; err == nil {
			c.JSON(400, gin.H{
				"message": "already have this period",
			})
			return
		}

		if claims["id"] != nil {
			courtReport.CreatedUID = int(claims["id"].(float64))
		}
		db.NewRecord(courtReport)
		if err := db.Create(&courtReport).Error; err != nil {
			c.JSON(404, gin.H{
				"message": err.Error(),
			})
			fmt.Println(err)
		} else {
			c.JSON(200, courtReport)
		}
	} else {
		c.JSON(400, valid.Errors)
	}

}