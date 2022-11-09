package main

import (
	"fmt"

	"github.com/RyabovNick/databasecourse_2/golang/tasks/people_service/service/store"
)

func main() {
	conn := "postgresql://kireichikov:kireichikov@95.217.232.188:7777/kireichikov"
	s := store.NewStore(conn)
	num := "3"
	print("\n")
	println("Пользователь с индексом", num)
	fmt.Println(s.GetPeopleByID(num))
	print("\n")
	println("Список всех пользователей:")
	fmt.Print(s.ListPeople())

}
