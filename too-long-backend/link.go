// link.go

package main

import "github.com/jinzhu/gorm"

type Link struct {
	gorm.Model
	URL         string `gorm:"column:url"`
	Description string `gorm:"column:description"`
}
