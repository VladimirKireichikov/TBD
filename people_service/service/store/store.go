package store

import (
	"context"
	"fmt"
	"log"
	"os"
	"strconv"

	"github.com/golang-migrate/migrate/v4"
	_ "github.com/golang-migrate/migrate/v4/database/postgres"
	_ "github.com/golang-migrate/migrate/v4/source/file"
	"github.com/jackc/pgx/v5"
)

type Store struct {
	conn *pgx.Conn
}

type People struct {
	ID   int
	Name string
}

// NewStore creates new database connection
func NewStore(connString string) *Store {
	conn, err := pgx.Connect(context.Background(), connString)
	if err != nil {
		panic(err)
	}
	//код взял с материалов, которые нам были предоставлены https://github.com/golang-migrate/migrate/blob/master/database/postgres/TUTORIAL.md
	m, err := migrate.New("file://migrations", connString)
	if err != nil {
		log.Fatal(err)
	}

	if err := m.Up(); err != nil {
		log.Fatal(err)
	}

	return &Store{
		conn: conn,
	}
}

func (s *Store) ListPeople() ([]People, error) {

	var mas []People
	r, err := s.conn.Query(context.Background(), "SELECT id, name FROM people")
	if err != nil {
		log.Panic("error")
	}
	defer r.Close()

	for r.Next() {
		var person People

		if err = r.Scan(&person.ID, &person.Name); err != nil {
			log.Panic("error")
		}
		mas = append(mas, person)
	}
	if r.Err() != nil {
		fmt.Fprintf(os.Stderr, "scan failed %v\n", err)
	}
	return mas, err
}

func (s *Store) GetPeopleByID(id string) (People, error) {
	var name_ string
	err := s.conn.QueryRow(context.Background(), "SELECT name FROM people WHERE id=$1", id).Scan(&name_)
	id_, err := strconv.Atoi(id)
	if err != nil {
		log.Panic("Error")
	}
	return People{ID: id_, Name: name_}, err
}
