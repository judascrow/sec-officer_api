package controllers

import (
	"fmt"
	"sec-officer_api/include"
	"sec-officer_api/models"

	jwt "github.com/appleboy/gin-jwt/v2"
	"github.com/astaxie/beego/validation"
	"github.com/gin-gonic/gin"
)

// SecPersons Model
type SecPersons = models.SecPersons

// DataPersons Model
type DataPersons struct {
	Total int64        `json:"total"`
	Data  []SecPersons `json:"data"`
}

// GetSecPerson function
func GetSecPerson(c *gin.Context) {
	id := c.Params.ByName("id")
	var secPersons SecPersons

	claims := jwt.ExtractClaims(c)

	userCourtID := 0

	if claims["court_id"] != nil {
		userCourtID = int(claims["court_id"].(float64))
	}
	if err := db.Where("id = ? AND  court_id = ?", id, userCourtID).First(&secPersons).Error; err != nil {

		c.AbortWithStatus(404)
		fmt.Println(err)

	} else {

		c.JSON(200, secPersons)
	}
}

// GetSecPersons function
func GetSecPersons(c *gin.Context) {
	db = include.GetDB()
	var secPersons []SecPersons
	var data DataPersons
	var count int64

	claims := jwt.ExtractClaims(c)
	userCourtID := 0
	if claims["court_id"] != nil {
		userCourtID = int(claims["court_id"].(float64))
	}

	query := db.Where("court_id = ?", userCourtID)

	if err := query.Find(&secPersons).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {

		query.Find(&secPersons).Count(&count)

		data.Total = count
		data.Data = secPersons

		c.JSON(200, data)
	}
}

// CreateSecPerson function
func CreateSecPerson(c *gin.Context) {
	db = include.GetDB()
	claims := jwt.ExtractClaims(c)

	var secPersons SecPersons

	c.BindJSON(&secPersons)

	valid := validation.Validation{}
	valid.Required(&secPersons.Nid, "nid").Message("nid is required")
	valid.Required(&secPersons.FullName, "full_name").Message("full_name is required")

	if !valid.HasErrors() {

		if err := db.Where("nid = ?", &secPersons.Nid).First(&secPersons).Error; err == nil {
			c.JSON(400, gin.H{
				"message": "already have this nid",
			})
			return
		}
		if claims["court_id"] != nil {
			secPersons.CourtID = int(claims["court_id"].(float64))
		}

		if claims["id"] != nil {
			secPersons.CreatedUid = int(claims["id"].(float64))
		}

		if err := db.Create(&secPersons).Error; err != nil {
			c.JSON(404, gin.H{
				"message": err.Error(),
			})
			fmt.Println(err)
		} else {
			c.JSON(200, secPersons)
		}
	} else {
		c.JSON(400, valid.Errors)
	}

}

// UpdateSecPerson function
func UpdateSecPerson(c *gin.Context) {
	db = include.GetDB()
	claims := jwt.ExtractClaims(c)

	var secPerson SecPersons
	id := c.Params.ByName("id")

	CourtID := 0
	if claims["court_id"] != nil {
		CourtID = int(claims["court_id"].(float64))
	}

	if err := db.Where("id = ? AND court_id = ?", id, CourtID).First(&secPerson).Error; err != nil {
		c.JSON(404, gin.H{
			"message": err.Error(),
		})
		fmt.Println(err)
		return
	}

	c.BindJSON(&secPerson)

	if claims["id"] != nil {
		secPerson.UpdatedUid = int(claims["id"].(float64))
	}

	if err := db.Save(&secPerson).Error; err != nil {
		c.JSON(404, gin.H{
			"message": err.Error(),
		})
		fmt.Println(err)
	} else {
		c.JSON(200, secPerson)
	}
}

// func DeleteUser(c *gin.Context) {
// 	db = include.GetDB()
// 	id := c.Params.ByName("id")
// 	var user User

// 	if err := db.Where("id = ? ", id).Delete(&user).Error; err != nil {
// 		c.AbortWithStatus(404)
// 		fmt.Println(err)
// 	} else {
// 		c.JSON(200, gin.H{"id#" + id: "deleted"})
// 	}
// }
