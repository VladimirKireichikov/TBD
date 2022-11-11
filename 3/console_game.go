package main

import (
	"bufio"
	"fmt"
	"math/rand"
	"os"
	"testing"
	"time"

	"github.com/stretchr/testify/assert"
)

type creature struct {
	Len, Hp, Res, Wght int
}

func main() {
	rand.Seed(time.Now().UnixNano())
	fmt.Println(`
	#######                                                                             
	   #    #####  #   #    #####  ####      ####  #    # #####  #    # # #    # ###### 
	   #    #    #  # #       #   #    #    #      #    # #    # #    # # #    # #      
	   #    #    #   #        #   #    #     ####  #    # #    # #    # # #    # #####  
	   #    #####    #        #   #    #         # #    # #####  #    # # #    # #      
	   #    #   #    #        #   #    #    #    # #    # #   #   #  #  #  #  #  #      
	   #    #    #   #        #    ####      ####   ####  #    #   ##   #   ##   ###### 
	`)
	var newCreature = creature{Len: 10, Hp: 100, Res: 20, Wght: 30}
	scanner := bufio.NewScanner(os.Stdin)
	for {
		fmt.Println("\n Длина норы: ", newCreature.Len, "\n Здоровье: ", newCreature.Hp, "\n Уважени: ", newCreature.Res, "\n Вес: ", newCreature.Wght)
		fmt.Println("Чем займемся сегодня?")
		fmt.Println("1. Копать нору")
		fmt.Println("2. Поесть травки")
		fmt.Println("3. Пойти подраться")
		fmt.Println("4. Поспать весь день")
		fmt.Println("5. Выход")
		scanner.Scan()
		input := scanner.Text()

		switch input {
		case "1":
			newCreature.Len, newCreature.Hp = Dig(newCreature.Len, newCreature.Hp)
		case "2":
			newCreature.Hp, newCreature.Wght = Eat(newCreature.Hp, newCreature.Wght, newCreature.Res)
		case "3":
			newCreature.Res, newCreature.Hp = Fight(newCreature.Res, newCreature.Hp, newCreature.Wght)
		case "4":
			newCreature.Len, newCreature.Hp, newCreature.Res, newCreature.Wght = Dream(newCreature.Len, newCreature.Hp, newCreature.Res, newCreature.Wght)
		case "5":
			fmt.Println("Exiting...")
			os.Exit(1)
		default:
			fmt.Println("Наслаждайся игрой, а не ломай её")
		}
		newCreature.Len -= 2
		newCreature.Hp += 20
		newCreature.Res -= 2
		newCreature.Wght -= 5
		if (newCreature.Hp < 0) || (newCreature.Len < 0) || (newCreature.Res < 0) || (newCreature.Wght < 0) {
			fmt.Println(`
			 #####                          #######                      
			#     #   ##   #    # ######    #     # #    # ###### #####  
			#        #  #  ##  ## #         #     # #    # #      #    # 
			#  #### #    # # ## # #####     #     # #    # #####  #    # 
			#     # ###### #    # #         #     # #    # #      #####  
			#     # #    # #    # #         #     #  #  #  #      #   #  
			 #####  #    # #    # ######    #######   ##   ###### #    #  
			`)
			os.Exit(1)
		}
		if newCreature.Res >= 100 {
			fmt.Println(`
			#     #                  #     #             ### ### ### 
			 #   #   ####  #    #    #  #  # # #    #    ### ### ### 
			  # #   #    # #    #    #  #  # # ##   #    ### ### ### 
			   #    #    # #    #    #  #  # # # #  #     #   #   #  
			   #    #    # #    #    #  #  # # #  # #                
			   #    #    # #    #    #  #  # # #   ##    ### ### ### 
			   #     ####   ####      ## ##  # #    #    ### ### ### 
		   `)
		}
		fmt.Println("Новый день, ты все еще живой")

	}
}
func Test(t *testing.T) {
	got := 10
	want := 20
	assert.Equal(t, want, got)
}
func Fight(r int, h int, w int) (int, int) {
	fmt.Println("С кем будем драться?")
	fmt.Println("1. Со слабачком")
	fmt.Println("2. Со средним противником")
	fmt.Println("3. Со здоровячком")
	reader := bufio.NewReader(os.Stdin)
	userChoice, _, error := reader.ReadRune()
	h1 := 30
	h2 := 50
	h3 := 70
	rnd := rand.Intn(100)
	fmt.Println(rnd)
	var q float32 = float32(w) / float32((h1 + w))
	if error != nil {
		fmt.Println(error)
	}
	switch userChoice {
	case '1':
		if rnd <= int(q*100) {
			fmt.Println("Ну такого бы и моя бабушка повалила, но ты все равно молодец")
			if w > h1 {
				r += 5
			}
			if w == h1 {
				r += 20
			}
			if w < h1 {
				r += 40
			}
		} else {
			fmt.Println("Ну ты даешь, ладно в следующий раз повезет")
			if w > h1 {
				h -= 10
			}
			if w == h1 {
				h -= 15
			}
			if w < h1 {
				h -= 20
			}
		}
	case '2':
		if rnd <= int(q*100) {
			fmt.Println("Вполне неплохо, для тебя, ты победил")
			if w > h2 {
				r += 5
			}
			if w == h2 {
				r += 20
			}
			if w < h2 {
				r += 40
			}
		} else {
			fmt.Println("Иди пытайся победить кого послабже, может тогда победишь")
			if w > h2 {
				h -= 20
			}
			if w == h2 {
				h -= 25
			}
			if w < h2 {
				h -= 30
			}
		}
	case '3':
		if rnd <= int(q*100) {
			fmt.Println("Сразу видно, настоящий мужчина, наверно...")
			if w > h3 {
				r += 5
			}
			if w == h3 {
				r += 20
			}
			if w < h3 {
				r += 40
			}
		} else {
			fmt.Println("Я тебе говорил: 'Не лезь оно тебя сожрет'")
			if w > h3 {
				h -= 35
			}
			if w == h3 {
				h -= 40
			}
			if w < h3 {
				h -= 45
			}
		}
	default:
		fmt.Println("Так не получиться")
	}
	return r, h
}
func Dream(l int, h int, r int, w int) (int, int, int, int) {
	l -= 2
	h += 20
	r -= 2
	w -= 5
	return l, h, r, w
}
func Dig(l int, h int) (int, int) {
	fmt.Println("Как будем копать?")
	fmt.Println("1. Интенсивно: \n Длина норы + 5 \n Здоровье - 30")
	fmt.Println("\n2. Лениво: \n Длина норы + 2 \n Здоровье - 10")
	reader := bufio.NewReader(os.Stdin)
	userChoice, _, error := reader.ReadRune()

	if error != nil {
		fmt.Println(error)
	}
	switch userChoice {
	case '1':
		fmt.Println("\nВы усердно копаете себе яму, в следствии чего чувствуете себя хуже")
		l += 5
		h += -30
	case '2':
		fmt.Println("\nВы маловато поработали, зато несильно устали")
		l += 2
		h -= 10
	default:
		fmt.Println("Так не получиться")
	}
	return l, h
}
func Eat(h int, w int, r int) (int, int) {
	fmt.Println("Какую траву будем есть?")
	fmt.Println("1. Жухлую")
	fmt.Println("2. Зеленую")
	reader := bufio.NewReader(os.Stdin)
	userChoice, _, error := reader.ReadRune()

	if error != nil {
		fmt.Println(error)
	}

	switch userChoice {
	case '1':
		fmt.Println("\nВы последнюю жухлую траву без соли доедаете, но что поделать")
		h += 10
		w += 10
	case '2':
		fmt.Println("Красиво жить не запретишь")
		if r < 30 {
			fmt.Println("Все таки нет, запретишь")
			h -= 30
		} else {
			h += 30
			w += 30
		}
	default:
		fmt.Println("Так не получиться")
	}
	return h, w
}
