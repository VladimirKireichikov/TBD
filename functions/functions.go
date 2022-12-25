package functions

import (
	"bufio"
	"fmt"
	"math/rand"
	"os"
)

type creature struct {
	len, hp, res int
	wght         float64
}

func New(len int, hp int, res int, wght float64) *creature {
	return &creature{
		len,
		hp,
		res,
		wght}
}

func (a *creature) Day(choice string) {
	switch choice {
	case "1":
		a.Dig()
	case "2":
		a.Eat()
	case "3":
		a.Fight()
	case "4":
		a.Night()
	}
}
func (a *creature) Night() {
	a.len -= 2
	a.hp += 20
	a.res -= 2
	a.wght -= 5
}
func Roll(a *creature, h float64) float64 {
	q := a.wght / (h + a.wght)
	return q
}
func Defeat(a *creature, h float64) {
	fmt.Println("Иди пытайся победить кого послабже, может тогда победишь")
	if a.wght < h {
		a.hp -= 40
	} else if a.wght == h {
		a.hp -= 30
	} else if a.wght > h {
		a.hp -= 20

	}

}
func Win(a *creature, h float64) {
	fmt.Println("Ну такого бы и моя бабушка повалила, но ты все равно молодец")
	if a.wght < h {
		a.res += 40
	} else if a.wght == h {
		a.res += 20
	} else if a.wght > h {
		a.res += 5
	}

}
func (a *creature) Fight() {
	fmt.Println("С кем будем драться?")
	fmt.Println("1. Со слабачком")
	fmt.Println("2. Со средним противником")
	fmt.Println("3. Со здоровячком")
	reader := bufio.NewReader(os.Stdin)
	userChoice, _, error := reader.ReadRune()
	h1 := 30.0
	h2 := 50.0
	h3 := 70.0
	result := rand.Float64()
	if error != nil {
		fmt.Println(error)
	}
	switch userChoice {
	case '1':
		q := Roll(a, h1)
		if result <= q {
			Defeat(a, h1)
		} else if result > q {
			Win(a, h1)
		}
	case '2':
		q := Roll(a, h2)
		if result <= q {
			Defeat(a, h2)
		} else if result > q {
			Win(a, h2)
		}
	case '3':
		q := Roll(a, h3)
		if result <= q {
			Defeat(a, h3)
		} else if result > q {
			Win(a, h1)
		}
	default:
		fmt.Println("Так не получиться")
	}
}
func Dream(l int, h int, r int, w int) (int, int, int, int) {
	l -= 2
	h += 20
	r -= 2
	w -= 5
	return l, h, r, w
}
func (a *creature) Dig() {
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
		a.len += 5
		a.hp += -30
	case '2':
		fmt.Println("\nВы маловато поработали, зато несильно устали")
		a.len += 2
		a.hp -= 10
	default:
		fmt.Println("Так не получиться")
	}
}
func (a *creature) Eat() {
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
		a.hp += 10
		a.wght += 10
	case '2':
		fmt.Println("Красиво жить не запретишь")
		if a.res < 30 {
			fmt.Println("Все таки нет, запретишь")
			a.hp -= 30
		} else {
			a.hp += 30
			a.wght += 30
		}
	default:
		fmt.Println("Так не получиться")
	}
}
