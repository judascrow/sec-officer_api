package controllers

import (
	"fmt"
	"sec-officer_api/include"
	"sec-officer_api/models"

	jwt "github.com/appleboy/gin-jwt/v2"
	"github.com/astaxie/beego/validation"
	"github.com/gin-gonic/gin"
	//"path/filepath"
)

// CourtReport Model
type CourtReport = models.CourtReport

// CourtReportSecPerson Model
type CourtReportSecPerson = models.CourtReportSecPerson

// DataCourtReport Model
type DataCourtReport struct {
	Total int64         `json:"total"`
	Data  []CourtReport `json:"data"`
}

// GetCourtReports function
func GetCourtReports(c *gin.Context) {
	db = include.GetDB()
	var courtReports []CourtReport
	var data DataCourtReport
	var count int64

	
	status := c.DefaultQuery("status", "")
	year := c.DefaultQuery("year", "")
	month := c.DefaultQuery("month", "")

	claims := jwt.ExtractClaims(c)
	userCourtID := 0
	if claims["court_id"] != nil {
		userCourtID = int(claims["court_id"].(float64))
	}

	query := db.Set("gorm:auto_preload", true)

	if claims["role_id"] != nil  {
		if int(claims["role_id"].(float64)) > 1 {
			query = query.Where("court_id = ?", userCourtID)
			if status != "" && status != "Z" {
				query = query.Where("status = ?", status)
			}
		
			if year != "" {
				query = query.Where("year = ?", year)
			}
		
			if month != "" {
				query = query.Where("month = ?", month)
			}
		} else {
			query = query.Select("users.court_id ,court_reports.*").Joins("RIGHT JOIN users ON users.court_id = court_reports.court_id AND court_reports.year = ? AND court_reports.month = ? ",year,month).Where("users.role_id != ?", 1)
		}
	}



	if err := query.Order("year desc, month desc").Find(&courtReports).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {

		query.Find(&courtReports).Count(&count)

		data.Total = count
		if int(claims["role_id"].(float64)) == 1 {
			length := len(courtReports)

			for i := 0; i < length; i++ {
				if courtReports[i].Status == "" {
					courtReports[i].Status = "W"
				}
				
			}			
		}		
		data.Data = courtReports

		c.JSON(200, data)
	}
}

// GetCourtReport function
func GetCourtReport(c *gin.Context) {
	db = include.GetDB()
	id := c.Params.ByName("id")
	var courtReport CourtReport

	var courtReportSecPerson []CourtReportSecPerson

	claims := jwt.ExtractClaims(c)

	userCourtID := 0

	if claims["court_id"] != nil {
		userCourtID = int(claims["court_id"].(float64))
	}
	if err := db.Where("id = ? AND  court_id = ?", id, userCourtID).First(&courtReport).Error; err != nil {

		c.JSON(404, gin.H{
			"message": "ไม่พบข้อมูล",
		})
		fmt.Println(err)

	} else {
		db.Model(&courtReport).Related(&courtReportSecPerson)

		courtReport.CourtReportSecPersons = courtReportSecPerson
		c.JSON(200, courtReport)
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

		length := len(courtReport.CourtReportSecPersons)

		for i := 0; i < length; i++ {
			if courtReport.CourtReportSecPersons[i].Type == 1 {
				courtReport.CourtReportSecPersons[i].DayMonth = courtReport.Work7Day
			} else {
				courtReport.CourtReportSecPersons[i].DayMonth = courtReport.Work6Day
			}

			courtReport.TotalShuffle += courtReport.CourtReportSecPersons[i].Shuffle
			courtReport.TotalShuffleExcept += courtReport.CourtReportSecPersons[i].ShuffleExcept
			courtReport.TotalShuffleAbsence += courtReport.CourtReportSecPersons[i].ShuffleAbsence
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

// UpdateCourtReport function
func UpdateCourtReport(c *gin.Context) {
	db = include.GetDB()
	claims := jwt.ExtractClaims(c)

	var courtReport CourtReport
	id := c.Params.ByName("id")

	CourtID := 0
	if claims["court_id"] != nil {
		CourtID = int(claims["court_id"].(float64))
	}

	if err := db.Where("id = ? AND court_id = ?", id, CourtID).First(&courtReport).Error; err != nil {
		c.JSON(404, gin.H{
			"message": err.Error(),
		})
		fmt.Println(err)
		return
	}

	c.BindJSON(&courtReport)

	if claims["id"] != nil {
		courtReport.UpdatedUID = int(claims["id"].(float64))
	}

	courtReport.Status = "W"

	length := len(courtReport.CourtReportSecPersons)

	for i := 0; i < length; i++ {
		if courtReport.CourtReportSecPersons[i].Type == 1 {
			courtReport.CourtReportSecPersons[i].DayMonth = courtReport.Work7Day
		} else {
			courtReport.CourtReportSecPersons[i].DayMonth = courtReport.Work6Day
		}

		courtReport.TotalShuffle += courtReport.CourtReportSecPersons[i].Shuffle
		courtReport.TotalShuffleExcept += courtReport.CourtReportSecPersons[i].ShuffleExcept
		courtReport.TotalShuffleAbsence += courtReport.CourtReportSecPersons[i].ShuffleAbsence
	}

	if err := db.Save(&courtReport).Error; err != nil {
		c.JSON(404, gin.H{
			"message": err.Error(),
		})
		fmt.Println(err)
	} else {
		c.JSON(200, courtReport)
	}
}

// DeleteCourtReport Function
func DeleteCourtReport(c *gin.Context) {
	db = include.GetDB()
	id := c.Params.ByName("id")
	var courtReport CourtReport

	claims := jwt.ExtractClaims(c)
	userCourtID := 0
	if claims["court_id"] != nil {
		userCourtID = int(claims["court_id"].(float64))
	}

	if err := db.Where("id = ? AND court_id = ? ", id, userCourtID).Delete(&courtReport).Error; err != nil {
		c.JSON(404, gin.H{"message": err.Error()})
		fmt.Println(err)
	} else {

		if err := db.Where("court_report_id = ?", id).Delete(CourtReportSecPerson{}).Error; err != nil {
			c.JSON(404, gin.H{"message": err.Error()})
			fmt.Println(err)
		} else {
			c.JSON(200, gin.H{"status": "deleted"})
		}

	}
}

// UploadFile Function
func UploadFile(c *gin.Context) {
	db = include.GetDB()
	id := c.Params.ByName("id")
	claims := jwt.ExtractClaims(c)
	var courtReport CourtReport
	var d DocNo

	CourtID := 0
	if claims["court_id"] != nil {
		CourtID = int(claims["court_id"].(float64))
	}

	// Source
	file, err := c.FormFile("file")
	if err != nil {
		c.JSON(400, gin.H{"message": err.Error()})
		return
	}
	c.Bind(&d)
	filename := "report_" + id + ".pdf"
	filePath := "uploads/" + filename
	if err := c.SaveUploadedFile(file, filePath); err != nil {
		c.JSON(400, gin.H{"message": err.Error()})
		return
	}

	updatedUID := 0
	if claims["id"] != nil {
		updatedUID = int(claims["id"].(float64))
	}

	db.Model(&courtReport).Where("id = ? AND court_id = ?", id, CourtID).Updates(map[string]interface{}{"file_path": filename, "doc_no": d.DocNo, "status": "S", "updated_uid": updatedUID})

	c.JSON(200, courtReport)
}

// AcceptReport Function
func AcceptReport(c *gin.Context) {
	db = include.GetDB()
	id := c.Params.ByName("id")
	claims := jwt.ExtractClaims(c)
	var courtReport CourtReport

	updatedUID := 0
	if claims["id"] != nil {
		updatedUID = int(claims["id"].(float64))
	}

	db.Model(&courtReport).Where("id = ?  AND status = ? ", id, "S").Updates(map[string]interface{}{"status": "A", "updated_uid": updatedUID})

	c.JSON(200, courtReport)
}

// AcceptReport Function
func UnAcceptReport(c *gin.Context) {
	db = include.GetDB()
	id := c.Params.ByName("id")
	claims := jwt.ExtractClaims(c)
	var courtReport CourtReport

	updatedUID := 0
	if claims["id"] != nil {
		updatedUID = int(claims["id"].(float64))
	}

	db.Model(&courtReport).Where("id = ?  AND status = ? ", id, "A").Updates(map[string]interface{}{"status": "S", "updated_uid": updatedUID})

	c.JSON(200, courtReport)
}

// DocNo models
type DocNo struct {
	DocNo string `form:"doc_no"`
}
