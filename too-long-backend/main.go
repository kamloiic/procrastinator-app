//main.go

package main

import (
	"fmt"
	"log"
	"os"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
	

)

var db *gorm.DB
var err error

type Link struct {
	gorm.Model
	URL         string `gorm:"column:url"`
	Description string `gorm:"column:description"`
}

func main() {
	// Connect to the PostgreSQL database
	dbHost := os.Getenv("DB_HOST")
    dbPort := os.Getenv("DB_PORT")
    dbUser := os.Getenv("DB_USER")
    dbPassword := os.Getenv("DB_PASSWORD")
    dbName := os.Getenv("DB_NAME")
    
    // Construct the database connection string
    dbConnectionString := fmt.Sprintf("host=%s port=%s user=%s dbname=%s password=%s sslmode=disable", dbHost, dbPort, dbUser, dbName, dbPassword)

	db, err = gorm.Open("postgres", dbConnectionString)
    if err != nil {
        log.Fatal("Failed to connect to database: ", err)
    }
    defer db.Close()

	// Automigrate the Link struct to create the "links" table in the database
	db.AutoMigrate(&Link{})

	// Initialize the Gin router
	r := gin.Default()

	r.Use(cors.Default())

	// Define the API endpoints
	r.GET("/links", getLinks)
	r.POST("/links", createLink)
	r.DELETE("/links/:id", deleteLink)

	// Start the server
	port := 8080
	fmt.Printf("Server started on port %d\n", port)
	r.Run(fmt.Sprintf(":%d", port))
}

func getLinks(c *gin.Context) {
	var links []Link
	db.Find(&links)
	c.JSON(200, links)
}

// Create a new link
func createLink(c *gin.Context) {
	var link Link
	c.BindJSON(&link)
	db.Create(&link)
	c.JSON(201, link)
}

// Delete a link by ID
func deleteLink(c *gin.Context) {
	id := c.Param("id")
	var link Link
	db.First(&link, id)
	if link.ID == 0 {
		c.JSON(404, gin.H{"error": "Link not found"})
		return
	}
	db.Delete(&link)
	c.JSON(200, gin.H{"message": "Link deleted successfully"})
}
