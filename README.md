# Coffee ☕

## Disclaimer

This software is not intended to be used on servers that do not allow it. Please consult the rules of the server you are playing on before attempting to launch Coffee. Thank you!

## Overview

Coffee is a lightweight and modular trainer for Garry's Mod. It provides useful features to enhance gameplay experiences. Features include:
  * Dynamically resizable menu frames.
  * Dynamic aim assistance with spread compensation, recoil compensation, autowall, minimum damage, and more.
  * Hitbox manager with dynamic parsing of hitboxes.
  * Modular architecture with various modules supported.
  * Feature-rich player visuals with unique effects, including custom cham materials, glow options, lighting effects, and more.
  * Various world effects including weather modulation, world modulation, skybox modulation, and more.
  * Item list with various entities dynamically included.
  * Modular plugin system for extra customization.
  * Moat.gg & Modern TTT fork support.
  * Sandbox PVP/Buildmode support.

<details>
  <summary>Images and Screenshots</summary>
  
  ![Coffee Image #1](https://i.imgur.com/Deh1ty6.png)
  ![Coffee Image #2](https://i.imgur.com/WA4clS2.png)
  ![Coffee Image #3](https://i.imgur.com/KPONjcC.png)
  ![Coffee Image #4](https://i.imgur.com/JBaBUuz.png)
  ![Coffee Image #5](https://i.imgur.com/6wSG0Qk.png)
  ![Coffee Image #6](https://i.imgur.com/QBiTzlm.png)
</details>

## Installation

You can install Coffee via the [releases](https://github.com/ryanoutcome20/Coffee/releases/) or manually by following these steps:

1. Cloning the repository:
   ```bash
   git clone https://github.com/ryanoutcome20/coffee.git
   ```
2. Dragging and dropping into your Garry's Mod folder located in:
   ```
   Steam/steamapps/common/GarrysMod/garrysmod/
   ```
3. Running via the console command:
   ```lua
   lua_openscript_cl coffee/main.lua
   ```

Note that the server must have **sv_allowcslua** enabled for this command to work. Also note that Coffee relies on external modules to extend its functionality, supported modules include:
  * [zxcmodule](https://github.com/ryanoutcome20/zxcmodule)
  * [proxi](https://github.com/homonovus)

It is likely you'll crash with zxcmodule due to load order issues. To fix this you must run:

```lua
lua_run_cl require("zxcmodule")
```

Do this **before** loading Coffee.

## Opening

Once loaded you can open the menu and begin configuring the trainer via the keybind **INSERT**. To open a tab click on the name of the tab located in the bottom left of your screen.

## Additional Information

### Contributing

Contributions are welcome! If you find a bug or want to add a new feature, feel free to fork the repository and submit a pull request.

### License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](./LICENSE) file for more details.
