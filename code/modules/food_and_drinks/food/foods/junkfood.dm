
//////////////////////
//		Vendor		//
//////////////////////

/obj/item/reagent_containers/food/snacks/chips
	name = "chips"
	desc = "Commander Riker's What-The-Crisps."
	icon_state = "chips"
	bitesize = 1
	trash = /obj/item/trash/chips
	filling_color = "#E8C31E"
	junkiness = 20
	antable = FALSE
	list_reagents = list("nutriment" = 1, "sodiumchloride" = 1, "sugar" = 2)
	tastes = list("crisps" = 1)
	foodtype = JUNKFOOD | FRIED

/obj/item/reagent_containers/food/snacks/sosjerky
	name = "Scaredy's Private Reserve Beef Jerky"
	icon_state = "sosjerky"
	desc = "Beef jerky made from the finest space cows."
	trash = /obj/item/trash/sosjerky
	filling_color = "#631212"
	junkiness = 25
	antable = FALSE
	list_reagents = list("protein" = 1, "sugar" = 3)
	tastes = list("chewy beef" = 1)
	foodtype = JUNKFOOD | MEAT

/obj/item/reagent_containers/food/snacks/pistachios
	name = "pistachios"
	icon_state = "pistachios"
	desc = "Deliciously salted pistachios. A perfectly valid choice..."
	trash = /obj/item/trash/pistachios
	filling_color = "#BAD145"
	junkiness = 20
	antable = FALSE
	list_reagents = list("plantmatter" = 2, "sodiumchloride" = 1, "sugar" = 2)
	tastes = list("pistachios" = 1)
	foodtype = JUNKFOOD

/obj/item/reagent_containers/food/snacks/no_raisin
	name = "4no Raisins"
	icon_state = "4no_raisins"
	desc = "Best raisins in the universe. Not sure why."
	trash = /obj/item/trash/raisins
	filling_color = "#343834"
	junkiness = 25
	antable = FALSE
	list_reagents = list("plantmatter" = 2, "sugar" = 2)
	tastes = list("dried raisins" = 1)
	foodtype = JUNKFOOD | FRUIT

/obj/item/reagent_containers/food/snacks/spacetwinkie
	name = "Space Twinkie"
	icon_state = "space_twinkie"
	desc = "Guaranteed to survive longer then you will."
	trash = /obj/item/trash/spacetwinkie
	filling_color = "#FFE591"
	junkiness = 25
	list_reagents = list("sugar" = 4)
	tastes = list("twinkies" = 1)
	foodtype = JUNKFOOD | SUGAR

/obj/item/reagent_containers/food/snacks/cheesiehonkers
	name = "Cheesie Honkers"
	icon_state = "cheesie_honkers"
	desc = "Bite sized cheesie snacks that will honk all over your mouth."
	trash = /obj/item/trash/cheesie
	filling_color = "#FFA305"
	junkiness = 25
	antable = FALSE
	list_reagents = list("nutriment" = 1, "fake_cheese" = 2, "sugar" = 3)
	tastes = list("cheese" = 1, "crisps" = 2)
	foodtype = JUNKFOOD | DAIRY

/obj/item/reagent_containers/food/snacks/syndicake
	name = "Syndi-Cakes"
	icon_state = "syndi_cakes"
	desc = "An extremely moist snack cake that tastes just as good after being nuked."
	filling_color = "#FF5D05"
	trash = /obj/item/trash/syndi_cakes
	bitesize = 3
	antable = FALSE
	list_reagents = list("nutriment" = 4, "salglu_solution" = 5)
	tastes = list("sweetness" = 3, "cake" = 1)
	foodtype = JUNKFOOD

/obj/item/reagent_containers/food/snacks/tastybread
	name = "bread tube"
	desc = "Bread in a tube. Chewy and surprisingly tasty."
	icon_state = "tastybread"
	trash = /obj/item/trash/tastybread
	filling_color = "#A66829"
	junkiness = 20
	antable = FALSE
	list_reagents = list("protein" = 2, "sugar" = 2)
	tastes = list("bread" = 1)
	foodtype = JUNKFOOD | GRAIN

/obj/item/reagent_containers/food/snacks/doshik
	name = "Doshi Co"
	desc = "Very famous instant noodles. When opened, it brewes immediantly. Wow."
	icon_state = "doshik"
	trash = /obj/item/trash/doshik
	filling_color = "#d1a62f"
	junkiness = 20
	list_reagents = list("protein" = 3)
	tastes = list("doshi co" = 1, "pleasure" = 1)
	foodtype = JUNKFOOD | MEAT
	opened = FALSE

/obj/item/reagent_containers/food/snacks/doshik_spicy
	name = "Doshi Co Special"
	desc = "Very famous instant noodles. When opened, it brewes immediantly. Wow. It seems to have hot spices in it."
	icon_state = "doshikspicy"
	trash = /obj/item/trash/doshik
	filling_color = "#d16a2f"
	junkiness = 20
	list_reagents = list("protein" = 3, "capsaicin" = 5)
	tastes = list("doshi co" = 1, "pain" = 1, "pleasure" = 1)
	foodtype = JUNKFOOD | MEAT
	opened = FALSE


/obj/item/reagent_containers/food/snacks/macvulpix_nachos
	name = "\improper MacNachos Diablo"
	icon_state = "macvulpix_nachos"
	desc = "Лис на упаковке словно говорит вам \"Это, черт возьми, остро!\""
	trash = /obj/item/trash/macvulpix_nachos
	filling_color = "#BAD145"
	junkiness = 20
	antable = FALSE
	list_reagents = list("plantmatter" = 3, "sodiumchloride" = 1, "capsaicin" = 5)
	tastes = list("crisps" = 1, "very spicy nachos" = 5)
	foodtype = JUNKFOOD | DAIRY


//////////////////////
//		Homemade	//
//////////////////////

/obj/item/reagent_containers/food/snacks/sosjerky/healthy
	name = "homemade beef jerky"
	desc = "Homemade beef jerky made from the finest space cows."
	list_reagents = list("nutriment" = 3, "vitamin" = 1)
	junkiness = 0
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/no_raisin/healthy
	name = "homemade raisins"
	desc = "homemade raisins, the best in all of spess."
	list_reagents = list("nutriment" = 3, "vitamin" = 2)
	junkiness = 0
	foodtype = FRUIT
