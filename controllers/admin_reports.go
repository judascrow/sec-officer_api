package controllers

import (
	"fmt"
	"sec-officer_api/include"
	"sec-officer_api/models"

	"github.com/gin-gonic/gin"
)

// AdminReport Model
type AdminReport = models.AdminReport

// AdminReportChild Model
type AdminReportChild = models.AdminReportChild

// GetAdminReport function
func GetAdminReport(c *gin.Context) {
	db = include.GetDB()
	var adminReport []AdminReport
	var adminReportChild AdminReportChild

	year := c.DefaultQuery("year", "")
	month := c.DefaultQuery("month", "")

	query := db.Table("court_reports a").Select("a.id, a.court_id, b.name AS court_name, b.department_name , a.year, a.month, a.total_shuffle_absence AS shuffle_absence, a.total_shuffle_except AS shuffle_except,a.doc_no , a.file_path").Joins("LEFT JOIN courts b ON a.court_id = b.id ")

	if year != "" {
		query = query.Where("year = ?", year)
	}

	if month != "" {
		query = query.Where("month = ?", month)
	}

	query = query.Where("status = ? ", "A")

	if err := query.Order("a.id DESC").Find(&adminReport).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {

		length := len(adminReport)
		for i := 0; i < length; i++ {

			if err := db.Table("court_report_sec_people").Select("SUM(CASE WHEN  type = 1 AND role = 1 THEN 1 ELSE 0 END ) AS type_7day_boss,SUM(CASE WHEN type = 1 AND role = 2 THEN 1 ELSE 0 END ) AS type_7day_operator, SUM(CASE WHEN  type = 2 AND role = 1 THEN 1 ELSE 0 END ) AS type_6day_boss,SUM(CASE WHEN type = 2 AND role = 2 THEN 1 ELSE 0 END ) AS type_6day_operator, COUNT(*) AS total , SUM(h_not12) AS h_not_12").Where("court_report_id = ?", adminReport[i].ID).Find(&adminReportChild).Error; err != nil {
				c.AbortWithStatus(404)
				fmt.Println(err)
			} else {
				adminReport[i].Type7DayBoss = adminReportChild.Type7DayBoss
				adminReport[i].Type7DayOperator = adminReportChild.Type7DayOperator
				adminReport[i].Type6DayBoss = adminReportChild.Type6DayBoss
				adminReport[i].Type6DayOperator = adminReportChild.Type6DayOperator
				adminReport[i].Total = adminReportChild.Total
				adminReport[i].HNot12 = adminReportChild.HNot12
			}

		}

		c.JSON(200, adminReport)
	}
}
