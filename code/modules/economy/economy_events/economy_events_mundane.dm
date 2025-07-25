
/datum/event/mundane_news
	endWhen = 10

/datum/event/mundane_news/announce()
	var/datum/trade_destination/affected_dest = pickweight(GLOB.weighted_mundaneevent_locations)
	var/event_type = 0
	if(length(affected_dest.viable_mundane_events))
		event_type = pick(affected_dest.viable_mundane_events)

	if(!event_type)
		return

	//copy-pasted from the admin verbs to submit new newscaster messages
	var/datum/feed_message/newMsg = new /datum/feed_message
	newMsg.author = "Nyx Daily"
	newMsg.admin_locked = TRUE
	newMsg.title = "[newMsg.author]: "

	//see if our location has custom event info for this event
	newMsg.body = affected_dest.get_custom_eventstring()
	newMsg.title = affected_dest.get_custom_eventtitle()
	if(!newMsg.body)
		switch(event_type)
			if(RANDOM_STORY_RESEARCH_BREAKTHROUGH)
				newMsg.title += "Research breakthrough at [affected_dest.name]"
				newMsg.body = "A major breakthrough in the field of [pick("plasma research","super-compressed materials","nano-augmentation","bluespace research","volatile power manipulation")] \
				was announced [pick("yesterday","a few days ago","last week","earlier this month")] by a private firm on [affected_dest.name]. \
				Nanotrasen declined to comment as to whether this could impinge on profits."

			if(RANDOM_STORY_ELECTION)
				newMsg.title += "Election on [affected_dest.name]"
				newMsg.body = "The pre-selection of an additional candidates was announced for the upcoming [pick("supervisors council","advisory board","governorship","board of inquisitors")] \
				election on [affected_dest.name] was announced earlier today, \
				[pick("media mogul","web celebrity", "industry titan", "superstar", "famed chef", "popular gardener", "ex-army officer", "multi-billionaire")] \
				[random_name(pick(MALE,FEMALE))]. In a statement to the media they said '[pick("My only goal is to help the [pick("sick","poor","children")]",\
				"I will maintain Nanotrasen's record profits","I believe in our future","We must return to our moral core","Just like... chill out dudes")]'."

			if(RANDOM_STORY_RESIGNATION)
				var/job = pick("Sector Admiral","Division Admiral","Ship Admiral","Vice Admiral")
				newMsg.title += "[job] retires"
				newMsg.body = "Nanotrasen regretfully announces the resignation of [job] [random_name(pick(MALE,FEMALE))]."
				if(prob(25))
					var/locstring = pick("Segunda","Salusa","Cepheus","Andromeda","Gruis","Corona","Aquila","Asellus") + " " + pick("I","II","III","IV","V","VI","VII","VIII")
					newMsg.body += " In a ceremony on [affected_dest.name] this afternoon, they will be awarded the \
					[pick("Red Star of Sacrifice","Purple Heart of Heroism","Blue Eagle of Loyalty","Green Lion of Ingenuity")] for "
					if(prob(33))
						newMsg.body += "their actions at the Battle of [pick(locstring,"REDACTED")]."
					else if(prob(50))
						newMsg.body += "their contribution to the colony of [locstring]."
					else
						newMsg.body += "their loyal service over the years."
				else if(prob(33))
					newMsg.body += " They are expected to settle down in [affected_dest.name], where they have been granted a handsome pension."
				else if(prob(50))
					newMsg.body += " The news was broken on [affected_dest.name] earlier today, where they cited reasons of '[pick("health","family","REDACTED")]'"
				else
					newMsg.body += " Administration Aerospace wishes them the best of luck in their retirement ceremony on [affected_dest.name]."

			if(RANDOM_STORY_CELEBRITY_DEATH)
				var/job = "Doctor"
				if(prob(33))
					job = "[pick("distinguished","decorated","veteran","highly respected")] \
					[pick("Ship's Captain","Vice Admiral","Colonel","Lieutenant Colonel")] "
				else if(prob(50))
					job = "[pick("award-winning","popular","highly respected","trend-setting")] \
					[pick("comedian","singer/songwright","artist","playwright","TV personality","model")] "
				else
					job = "[pick("successful","highly respected","ingenious","esteemed")] \
					[pick("academic","Professor","Doctor","Scientist")] "

				newMsg.title += "Famous [job] dies on [affected_dest.name]"
				newMsg.body = "It is with regret today that we announce the sudden passing of the "
				newMsg.body += "[job] [random_name(pick(MALE,FEMALE))] on [affected_dest.name] [pick("last week","yesterday","this morning","two days ago","three days ago")]\
				[pick(". Assassination is suspected, but the perpetrators have not yet been brought to justice",\
				" due to Syndicate infiltrators (since captured)",\
				" during an industrial accident",\
				" due to [pick("heart failure","kidney failure","liver failure","brain hemorrhage")]")]"

			if(RANDOM_STORY_BARGAINS)
				newMsg.title += "Bargains"
				newMsg.body += "Commerce Control on [affected_dest.name] wants you to know that everything must go! Across all retail centres, \
				all goods are being slashed, and all retailors are onboard - so come on over for the \[shopping\] time of your life."

			if(RANDOM_STORY_SONG_DEBUT)
				var/job = pick("Singer","Singer/songwriter","Saxophonist","Pianist","Guitarist","TV personality","Star")
				newMsg.title += "[job] Debuts"
				newMsg.body += "[job] [random_name(pick(MALE,FEMALE))] \
				announced the debut of their new [pick("single","album","EP","label")] '[pick("Everyone's","Look at the","Baby don't eye those","All of those","Dirty nasty")] \
				[pick("roses","three stars","starships","nanobots","cyborgs","Skrell","Sren'darr")] \
				[pick("on Venus","on Reade","on Moghes","in my hand","slip through my fingers","die for you","sing your heart out","fly away")]' \
				with [pick("pre-purchases available","a release tour","cover signings","a launch concert")] on [affected_dest.name]."

			if(RANDOM_STORY_MOVIE_RELEASE)
				var/movie_name = "[pick("Deadly","The last","Lost","Dead")] [pick("Starships","Warriors","outcasts","Tajarans","Unathi","Skrell")] \
				[pick("of","from","raid","go hunting on","visit","ravage","pillage","destroy")] \
				[pick("Moghes","Earth","Biesel","Ahdomai","S'randarr","the Void","the Edge of Space")]'."
				newMsg.title += "Now in Theaters: [movie_name]"
				newMsg.body += "From the [pick("desk","home town","homeworld","mind")] of [pick("acclaimed","award-winning","popular","stellar")] \
				[pick("playwright","author","director","actor","TV star")] [random_name(pick(MALE,FEMALE))] comes the latest sensation: [movie_name]. \
				Own it on webcast today, or visit the galactic premier on [affected_dest.name]!"

			if(RANDOM_STORY_BIG_GAME_HUNTERS)
				newMsg.title += "Unusual specimen on [affected_dest.name]"
				newMsg.body += "Game hunters on [affected_dest.name] "
				if(prob(33))
					newMsg.body += "were surprised when an unusual species experts have since identified as \
					[pick("a subclass of mammal","a divergent abhuman species","an intelligent species of lemur","organic/cyborg hybrids")] turned up. Believed to have been brought in by \
					[pick("alien smugglers","early colonists","Syndicate raiders","unwitting tourists")], this is the first such specimen discovered in the wild."
				else if(prob(50))
					newMsg.body += "were attacked by a vicious [pick("nas'r","diyaab","samak","predator which has not yet been identified")]\
					. Officials urge caution, and locals are advised to stock up on armaments."
				else
					newMsg.body += "brought in an unusually [pick("valuable","rare","large","vicious","intelligent")] [pick("mammal","predator","farwa","samak")] for inspection \
					[pick("today","yesterday","last week")]. Speculators suggest they may be tipped to break several records."

			if(RANDOM_STORY_GOSSIP)
				var/job = pick("TV host","Webcast personality","Superstar","Model","Actor","Singer")
				newMsg.title += "[job] Makes Big Announcement"
				newMsg.body += "[job] [random_name(pick(MALE,FEMALE))] "
				if(prob(33))
					newMsg.body += "and their partner announced the birth of their [pick("first","second","third")] child on [affected_dest.name] early this morning. \
					Doctors say the child is well, and the parents are considering "
					if(prob(50))
						newMsg.body += capitalize(pick(GLOB.first_names_female))
					else
						newMsg.body += capitalize(pick(GLOB.first_names_male))
					newMsg.body += " for the name."
				else if(prob(50))
					newMsg.body += "announced their [pick("split","break up","marriage","engagement")] with [pick("TV host","webcast personality","superstar","model","actor","singer")] \
					[random_name(pick(MALE,FEMALE))] at [pick("a society ball","a new opening","a launch","a club")] on [affected_dest.name] yesterday, pundits are shocked."
				else
					newMsg.body += "is recovering from plastic surgery in a clinic on [affected_dest.name] for the [pick("second","third","fourth")] time, reportedly having made the decision in response to "
					newMsg.body += "[pick("unkind comments by an ex","rumours started by jealous friends",\
					"the decision to be dropped by a major sponsor","a disastrous interview on Nyx Tonight")]."
			if(RANDOM_STORY_TOURISM)
				newMsg.title += "Tourists flock to [affected_dest.name]"
				newMsg.body += "Tourists are flocking to [affected_dest.name] after the surprise announcement of [pick("major shopping bargains by a wily retailer",\
				"a huge new ARG by a popular entertainment company","a secret tour by popular artiste [random_name(pick(MALE,FEMALE))]")]. \
				Nyx Daily is offering discount tickets for two to see [random_name(pick(MALE,FEMALE))] live in return for eyewitness reports and up to the minute coverage."
			else
				newMsg.body = ""

	GLOB.news_network.get_channel_by_name("Nyx Daily")?.add_message(newMsg)
	for(var/nc in GLOB.allNewscasters)
		var/obj/machinery/newscaster/NC = nc
		NC.alert_news(newMsg.title)

/datum/event/trivial_news
	endWhen = 10

/datum/event/trivial_news/announce()
	//copy-pasted from the admin verbs to submit new newscaster messages
	var/datum/feed_message/newMsg = new
	newMsg.author = "Editor Mike Hammers"
	var/datum/trade_destination/affected_dest = pick(GLOB.weighted_mundaneevent_locations)
	var/headline = pick(file2list("config/news/trivial.txt"))
	newMsg.title = replacetext(headline, "{{AFFECTED}}", affected_dest.name)

	GLOB.news_network.get_channel_by_name("The Gibson Gazette")?.add_message(newMsg)
	for(var/nc in GLOB.allNewscasters)
		var/obj/machinery/newscaster/NC = nc
		NC.alert_news("The Gibson Gazette: [newMsg.title]")
