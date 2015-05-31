#Exception Handler
###
#You can add different settings using this block
#Use the docs at http://github.com/richpeck/exception_handler for info
###
ExceptionHandler.setup do |config|

	#DB - 
	#Options = false / true
	config.db = false

	#Email -
	#Default = false / true
	#config.email = "p@pho.sx"

	#Social
	config.social = {
		twitter: "http://twitter.com/patnz",
		facebook:"#",
		linkedin:"#",
		youtube: "#",
		fusion:  "#"
	}

end
