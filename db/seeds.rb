Badge.delete_all
badges = [{name:"Interview Wonder", description:"Agents with this badge are ninjas at finding great interviews!"},{name:"Offer Master", description:"It's why we're all here: the offers! Offer Masters have proven they can get great offers out of pretty much anybody!"},{name:"Happy Talents",description:"Agents with the Happy Talents badge have a reputation for attracting great talent and finding exactly what they're looking for!"}] 
badges.each {|badge| Badge.create(badge)}
