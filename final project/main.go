package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"net/http"
	"strconv"
	"strings"

	tgbotapi "github.com/Syfaro/telegram-bot-api"
)

type bnResp struct {
	Price float64 `json:"price,string"`
	Code  int64   `json:"code"`
}
type users struct {
	id       int64
	Name     string
	Surname  string
	pwd      string
	is_admin bool
}

// База данных, грубо говоря string - название поле, float64 - тип значения
type wallet map[string]float64

//type users map[string]string

var db = map[int64]wallet{}

//var us = map[int64]users{}

func main() {

	//Создаем таблицу
	// подключаемся к боту с помощью токена
	bot, err := tgbotapi.NewBotAPI("5332282617:AAF8EGjLhGgm22fe6bkEjVNfBhl9VpVU6HA")
	if err != nil {
		log.Panic(err)
	}

	bot.Debug = true
	log.Printf("Authorized on account %s", bot.Self.UserName)

	// инициализируем канал, куда будут прилетать обновления от API
	u := tgbotapi.NewUpdate(0)
	u.Timeout = 60
	updates, err := bot.GetUpdatesChan(u)
	for update := range updates {
		if update.Message == nil {
			continue
		}
		command := strings.Split(update.Message.Text, " ")
		switch command[0] {
		case "/start":
			bot.Send(tgbotapi.NewMessage(update.Message.Chat.ID, "Приветствую вас, для дальнейшей работы вам необходимо авторизироваться\nДля этого введите команду /signin и ваше имя"))

		case "/signin":
			if (len(command)) != 3 {
				bot.Send(tgbotapi.NewMessage(update.Message.Chat.ID, "Неверная команда"))
			}
			// if _, ok := us[update.Message.Chat.ID]; !ok {
			// 	us[update.Message.Chat.ID] = users{}
			// }
			// us[update.Message.Chat.ID]["Name"] = command[1]
			us := users{id: update.Message.Chat.ID, Name: command[1], Surname: command[2]}
			a := fmt.Sprintf("Доброго времени суток, %s %s", us.Name, us.Surname)
			bot.Send(tgbotapi.NewMessage(update.Message.Chat.ID, a))
			bot.Send(tgbotapi.NewMessage(update.Message.Chat.ID, "Для вас доступны следущие команды:\n\nДобавление валюты в ошелек\n/add (Наименвание валюты) (количество)\n\nУменьшение количества валюты в кошелке\n/remove(Наименвание валюты) (количество)\n\nУдаление валюты их кошелька\n/delete (наименование валюты)\n\nПросмотр кошелька\n/show"))

		case "/add":
			if (len(command)) != 3 {
				bot.Send(tgbotapi.NewMessage(update.Message.Chat.ID, "Неверная команда"))
			}
			amount, err := strconv.ParseFloat(command[2], 64)
			if err != nil {
				bot.Send(tgbotapi.NewMessage(update.Message.Chat.ID, err.Error()))
			}
			if _, ok := db[update.Message.Chat.ID]; !ok {
				db[update.Message.Chat.ID] = wallet{}
			}
			db[update.Message.Chat.ID][command[1]] += amount
			balance := fmt.Sprintf("%f", db[update.Message.Chat.ID][command[1]])
			bot.Send(tgbotapi.NewMessage(update.Message.Chat.ID, balance))

		case "/remove":
			if (len(command)) != 3 {
				bot.Send(tgbotapi.NewMessage(update.Message.Chat.ID, "Неверная команда"))
			}
			amount, err := strconv.ParseFloat(command[2], 64)
			if err != nil {
				bot.Send(tgbotapi.NewMessage(update.Message.Chat.ID, err.Error()))
			}
			if _, ok := db[update.Message.Chat.ID]; !ok {
				continue
			}
			if db[update.Message.Chat.ID][command[1]]-amount > 0 {
				db[update.Message.Chat.ID][command[1]] -= amount
				balance := fmt.Sprintf("%f", db[update.Message.Chat.ID][command[1]])
				bot.Send(tgbotapi.NewMessage(update.Message.Chat.ID, balance))
			} else {
				bot.Send(tgbotapi.NewMessage(update.Message.Chat.ID, "У вас нет такого количества"))
			}

		case "/show":
			msg := " "
			var count int
			for key, value := range db[update.Message.Chat.ID] {
				price, _ := getPrice(key)
				msg += fmt.Sprintf("%s: %f [%.2f$]\n", key, value, value*price)
				count++
			}
			if count == 0 {
				bot.Send(tgbotapi.NewMessage(update.Message.Chat.ID, "Кошелек пуст"))
			} else {
				bot.Send(tgbotapi.NewMessage(update.Message.Chat.ID, msg))
			}

		case "/delete":
			if (len(command)) != 2 {
				bot.Send(tgbotapi.NewMessage(update.Message.Chat.ID, "Неверная команда"))
			}
			delete(db[update.Message.Chat.ID], command[1])

		default:
			bot.Send(tgbotapi.NewMessage(update.Message.Chat.ID, "Такого я еще не умею"))
		}
	}
}

func getPrice(symbol string) (price float64, err error) {
	resp, err := http.Get(fmt.Sprintf("https://api.binance.com/api/v3/ticker/price?symbol=%sUSDT", symbol))
	if err != nil {
		return
	}
	defer resp.Body.Close()
	var jsonResp bnResp
	err = json.NewDecoder(resp.Body).Decode(&jsonResp)
	if err != nil {
		return
	}
	if jsonResp.Code != 0 {
		err = errors.New("Неверный сивол")
	}
	price = jsonResp.Price
	return
}
