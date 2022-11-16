package main

import (
	"testing"

	"github.com/RyabovNick/databasecourse_p2/tree/master/golang/tasks/console_game/functions"
	"github.com/stretchr/testify/assert"
)

func Test_night(t *testing.T) {
	newCreature := functions.New(10, 100, 20, 30.0)
	newCreature.GoodNight()
	want := functions.New(8, 120, 18, 25.0)
	assert.Equal(t, newCreature, want)
}
func Test_win(t *testing.T) {
	newCreature := functions.New(10, 100, 20, 30.0)
	functions.Win(newCreature, 50.0)
	want := int64(50)
	assert.Equal(t, newCreature.res, want)
}

func Test_defeat(t *testing.T) {
	newCreature := functions.New(10, 100, 20, 30.0)
	functions.Defeat(newCreature, 50.0)
	want := int64(-40)
	assert.Equal(t, newCreature.hp, want)
}
