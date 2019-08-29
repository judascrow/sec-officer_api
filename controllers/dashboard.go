package controllers

import (
	"fmt"
	"sec-officer_api/include"
	"time"

	"github.com/gin-gonic/gin"
)

// TotalCourt models
type TotalCourt struct {
	Total int `json:"total"`
}

// GetTotalCourt function
func GetTotalCourt(c *gin.Context) {
	db := include.GetDB()
	var totalCourt TotalCourt

	if err := db.Table("users").Select("COUNT(distinct court_id) AS total").Where("role_id = 2").First(&totalCourt).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {

		c.JSON(200, totalCourt)
	}
}

// TotalCourtReport models
type TotalCourtReport struct {
	Total int `json:"total"`
}

// GetTotalCourtReport function
func GetTotalCourtReport(c *gin.Context) {
	db := include.GetDB()
	var totalCourtReport TotalCourtReport

	now := time.Now()
	yyyymm := now.AddDate(543, -1, 0).Format("2006-01")
	d := []rune(yyyymm)
	year := string(d[0:4])
	month := string(d[5:])

	if err := db.Table("court_reports").Select("COUNT(*) AS total").Where("year = ? AND month =  ? AND status !=  ? ", year, month, "W").First(&totalCourtReport).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {

		c.JSON(200, totalCourtReport)
	}
}

// TotalSec models
type TotalSec struct {
	Total int `json:"total"`
}

// GetTotalSec function
func GetTotalSec(c *gin.Context) {
	db := include.GetDB()
	var totalSec TotalSec

	if err := db.Table("sec_persons").Select("COUNT(id) AS total").Where("status =  ?", "A").First(&totalSec).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {

		c.JSON(200, totalSec)
	}
}

// TotalSecWork models
type TotalSecWork struct {
	Total float64 `json:"total"`
}

// GetTotalWork function
func GetTotalWork(c *gin.Context) {
	db := include.GetDB()
	var totalSecWork TotalSecWork
	// var courtReport []CourtReport

	now := time.Now()
	yyyymm := now.AddDate(543, -1, 0).Format("2006-01")
	d := []rune(yyyymm)
	year := string(d[0:4])
	month := string(d[5:])

	if err := db.Table("court_report_sec_people").Select("ROUND((AVG(day_month_work)/AVG(day_month)) * 100,1) AS total").Where("court_report_id IN (?)", db.Table("court_reports").Select("id").Where("year = ? AND month =  ? AND status =  ? ", year, month, "A").QueryExpr()).First(&totalSecWork).Error; err != nil {

		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {

		c.JSON(200, totalSecWork)

	}
}

// Bar models
type Bar struct {
	Depart   []ArrayDepart   `json:"depart"`
	SecTotal []ArraySecTotal `json:"sec_total"`
}

// ArrayDepart models
type ArrayDepart struct {
	Name string `json:"name"`
}

// ArraySecTotal models
type ArraySecTotal struct {
	Total int `json:"total"`
}

// GetArrayDepart function
func GetArrayDepart(c *gin.Context) {
	db := include.GetDB()
	var bar Bar
	var arrayDepart []ArrayDepart
	var arraySecTotal []ArraySecTotal

	if err := db.Table("sec_persons").Select("distinct department_name AS name").Joins("left join courts on courts.id = sec_persons.court_id").Group("department_name").Where("status =  ? ", "A").Find(&arrayDepart).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {

		if err := db.Table("sec_persons").Select("COUNT(sec_persons.id) AS total").Joins("left join courts on courts.id = sec_persons.court_id").Group("department_name").Where("status =  ? ", "A").Find(&arraySecTotal).Error; err != nil {
			c.AbortWithStatus(404)
			fmt.Println(err)
		} else {
			bar.SecTotal = arraySecTotal
		}

		bar.Depart = arrayDepart

		c.JSON(200, bar)
	}
}

// TotalSecWork2 models
type TotalSecWork2 struct {
	Donut1 Donut1 `json:"donut1"`
	Donut2 Donut2 `json:"donut2"`
	Donut3 Donut3 `json:"donut3"`
}

// Donut1 models
type Donut1 struct {
	Value float64 `json:"value"`
}

// Donut2 models
type Donut2 struct {
	Value float64 `json:"value"`
}

// Donut3 models
type Donut3 struct {
	Value float64 `json:"value"`
}

// GetTotalWork2 function
func GetTotalWork2(c *gin.Context) {
	db := include.GetDB()
	var totalSecWork2 TotalSecWork2
	var donut1 Donut1
	var donut2 Donut2
	var donut3 Donut3

	now := time.Now()
	yyyymm := now.AddDate(543, -1, 0).Format("2006-01")
	d := []rune(yyyymm)
	year := string(d[0:4])
	month := string(d[5:])

	if err := db.Table("court_report_sec_people").Select("cast((AVG(day_month_work)/AVG(day_month)) * 100 as decimal(10,2)) AS value").Where("court_report_id IN (?)", db.Table("court_reports").Select("id").Where("year = ? AND month =  ? AND status =  ? ", year, month, "A").QueryExpr()).Find(&donut1).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {
		totalSecWork2.Donut1 = donut1
	}

	if err := db.Table("court_report_sec_people").Select("cast((AVG(shuffle)/AVG(day_month)) * 100 as decimal(10,2)) AS value").Where("court_report_id IN (?)", db.Table("court_reports").Select("id").Where("year = ? AND month =  ? AND status =  ? ", year, month, "A").QueryExpr()).Find(&donut2).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {
		totalSecWork2.Donut2 = donut2
	}

	if err := db.Table("court_report_sec_people").Select("cast((AVG(shuffle_absence)/AVG(day_month)) * 100 as decimal(10,2)) AS value").Where("court_report_id IN (?)", db.Table("court_reports").Select("id").Where("year = ? AND month =  ? AND status =  ? ", year, month, "A").QueryExpr()).Find(&donut3).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {
		totalSecWork2.Donut3 = donut3
	}

	c.JSON(200, totalSecWork2)

}
