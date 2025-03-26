Place plugins you wish to run dynamically inside these folders. They will be ran automatically when Coffee is loaded.

garrysmod/coffee/unsafe - Will execute files in the regular environment for typical Lua execution (_G).
garrysmod/coffee/safe - Will execute files within the secured environment of Coffee. You'll be able to access all variables from Coffee.