package controllers

import (
	"fmt"
	"strconv"
	"strings"

	"sec-officer_api/include"
	"sec-officer_api/models"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

var db *gorm.DB
var err error

// Post struct alias
type Post = models.Post

// Tag struct alias
type Tag = models.Tag

// Data is mainle generated for filtering and pagination
type Data struct {
	Total int64  `json:"total"`
	Data  []Post `json:"data"`
}

// GetPost function
func GetPost(c *gin.Context) {
	db = include.GetDB()
	id := c.Params.ByName("id")
	var post Post
	var tags []Tag

	if err := db.Where("id = ? ", id).First(&post).Error; err != nil {

		c.AbortWithStatus(404)
		fmt.Println(err)

	} else {

		db.Model(&post).Related(&tags)
		// SELECT * FROM "tags"  WHERE ("post_id" = 1)

		post.Tags = tags
		c.JSON(200, post)
	}
}

// GetPosts function
func GetPosts(c *gin.Context) {
	db = include.GetDB()
	var posts []Post
	var data Data
	var count int64

	//Get name from query
	name := c.DefaultQuery("name", "")

	//Get description from query
	description := c.DefaultQuery("description", "")

	// Order By filtering option add
	Sort := c.DefaultQuery("order", "id|desc")
	SortArray := strings.Split(Sort, "|")

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

	query := db.Limit(limitInt)
	query = query.Offset(offsetInt)
	query = query.Order(SortArray[0] + " " + SortArray[1])

	// In postgres you shoud use ILIKE to make search case insensitive
	if name != "" {
		query = query.Where("name LIKE ?", "%"+name+"%")
	}

	if description != "" {
		query = query.Where("description LIKE ?", "%"+description+"%")
	}

	if err := query.Find(&posts).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {

		// We are resetting offset to 0 to return total number.
		// This is a fix for Gorm offset issue
		offsetInt = 0
		query = query.Offset(offsetInt)
		query.Table("posts").Count(&count)

		data.Total = count
		data.Data = posts

		c.JSON(200, data)
	}
}

// CreatePost function
func CreatePost(c *gin.Context) {
	db = include.GetDB()
	var post Post

	c.BindJSON(&post)

	if err := db.Create(&post).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {
		c.JSON(200, post)
	}
}

// UpdatePost function
func UpdatePost(c *gin.Context) {
	db = include.GetDB()
	var post Post
	id := c.Params.ByName("id")

	if err := db.Where("id = ?", id).First(&post).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	}

	c.BindJSON(&post)

	db.Save(&post)
	c.JSON(200, post)
}

// DeletePost function
func DeletePost(c *gin.Context) {
	db = include.GetDB()
	id := c.Params.ByName("id")
	var post Post

	if err := db.Where("id = ? ", id).Delete(&post).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {
		c.JSON(200, gin.H{"id#" + id: "deleted"})
	}
}
