package main

import (
	"bufio"
	"fmt"
	"os"

	"github.com/RyabovNick/databasecourse_p2/tree/master/golang/tasks/console_game/functions"
)

func main() {
	newCreature := functions.New(10, 100, 20, 30.0)
	fmt.Println(`
	#######                                                                             
	   #    #####  #   #    #####  ####      ####  #    # #####  #    # # #    # ###### 
	   #    #    #  # #       #   #    #    #      #    # #    # #    # # #    # #      
	   #    #    #   #        #   #    #     ####  #    # #    # #    # # #    # #####  
	   #    #####    #        #   #    #         # #    # #####  #    # # #    # #      
	   #    #   #    #        #   #    #    #    # #    # #   #   #  #  #  #  #  #      
	   #    #    #   #        #    ####      ####   ####  #    #   ##   #   ##   ###### 
	`)
	scanner := bufio.NewScanner(os.Stdin)
	for {
		fmt.Println("\n Длина норы: ", newCreature.len, "\n Здоровье: ", newCreature.hp, "\n Уважени: ", newCreature.res, "\n Вес: ", newCreature.wght)
		fmt.Println("Чем займемся сегодня?")
		fmt.Println("1. Копать нору")
		fmt.Println("2. Поесть травки")
		fmt.Println("3. Пойти подраться")
		fmt.Println("4. Поспать весь день")
		fmt.Println("5. Выход")
		scanner.Scan()
		input := scanner.Text()

		newCreature.Day(input)
		newCreature.Night()
		if (newCreature.hp < 0) || (newCreature.len < 0) || (newCreature.rea < 0) || (newCreature.wght < 0) {
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
		if newCreature.rea >= 100 {
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
