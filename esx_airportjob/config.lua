
Config = {
    
    --Marker Config
    MarkerType = 22, 
    MarkerTypeAvion = 33,

    MarkerSizeLargeur = 0.3,
    MarkerSizeLargeurGarageAvion = 0.5,

    MarkerSizeEpaisseur = 0.3,
    MarkerSizeEpaisseurGarageAvion = 0.5,

    MarkerSizeHauteur = 0.3, 
    MarkerSizeHauteurGarageAvion = 0.5,

    MarkerDistance = 20.0,
    MarkerColorR = 135, 
    MarkerColorG = 206, 
    MarkerColorB = 250, 

    MarkerOpacite = 255, 
    MarkerOpaciteMission = 0,
    
    --Config Points
    Position = {
        {
            Coffre = vector3(-938.05, -2931.64, 13.94), 
            CoffreEntrepot = vector3(-1306.29, -3390.01, 13.94),
            LivraisonColis = vector3(-1300.26, -3393.23, 13.94), 

            GarageVehicule = vector3(-931.49, -2921.23, 13.94),
            RangerVehicule = vector3(-919.07, -2928.91, 13.94),  
            RangerVehicule2 = vector3(-1648.42, -3136.41, 13.99),

            Vestiaire = vector3(-928.88, -2937.44, 13.94), 
            Boss = vector3(-941.44, -2954.82, 13.84),
            Ped = vector3(-1296.61, -3356.66, 13.94), 
        }
    },
 
    --Config Texte
    TextCoffre = "Appuyez sur ~HUD_COLOUR_BLUELIGHT~[E] ~s~pour accèder au ~HUD_COLOUR_BLUELIGHT~Stockage ~s~",
    TextCoffreEntrepot = "Appuyez sur ~HUD_COLOUR_BLUELIGHT~[E] ~s~pour accèder au ~HUD_COLOUR_BLUELIGHT~Stockage ~s~",

    TextGarage = "Appuyez sur ~HUD_COLOUR_BLUELIGHT~[E] ~s~pour accèder au ~HUD_COLOUR_BLUELIGHT~Garage",
    TextRangerGarage = "Appuyez sur ~HUD_COLOUR_BLUELIGHT~[E] ~s~pour ranger votre ~HUD_COLOUR_BLUELIGHT~Véhicule",
    TextVestiaire = "Appuyez sur ~HUD_COLOUR_BLUELIGHT~[E] ~s~pour accèder aux ~HUD_COLOUR_BLUELIGHT~Vestiaires.",
    TextBoss = "Appuyez sur ~HUD_COLOUR_BLUELIGHT~[E] ~s~pour accèder aux ~HUD_COLOUR_BLUELIGHT~Comptes Entreprise.",
    ParlerPed = "Appuyez sur ~HUD_COLOUR_BLUELIGHT~[E] ~s~pour parler au ~HUD_COLOUR_BLUELIGHT~Pilote.",

    
    --Config Vehicule Los Santos Airport
    Vehiculeairport = { 
        {buttoname = "Mini-Bus", rightlabel = "→→", spawnname = "rentalbus", spawnzone = vector3(-919.07, -2928.91, 13.94), headingspawn = 252.72}, -- Garage Voiture
        {buttoname = "Nimbus", rightlabel = "→→", spawnname = "nimbus", spawnzone = vector3(-1282.15, -3380.17, 13.94), headingspawn = 330.01}, -- Garage Avion
        {buttoname = "Velum", rightlabel = "→→", spawnname = "velum2", spawnzone = vector3(-1264.60, -3387.27, 13.94), headingspawn = 329.40}, -- Garage Avion
        {buttoname = "Deltaplane", rightlabel = "→→", spawnname = "microlight", spawnzone = vector3(-1245.94, -3383.72, 13.94), headingspawn = 327.95}, -- Garage Avion 
        {buttoname = "Hydravion", rightlabel = "→→", spawnname = "dodo", spawnzone = vector3(-1282.15, -3380.17, 13.94), headingspawn = 330.01}, -- Garage Avion 
    },
    
    PosPed = {
        Shops = {
            {
            pedPos = vector3(-1296.61, -3356.66, 13.94 - 1), heading = 269.22, pedModel = "mp_m_boatstaff_01", 
            pedPos2 = vector3(1331.11, 4269.79, 31.50 - 1), heading2 = 305.01, pedModel2 = "a_m_m_hillbilly_01",
            pedPos3 = vector3(1349.36, 4383.44, 44.34 - 1), heading3 = 305.20, pedModel3 = "u_f_o_prolhost_01",
            pedPos4 = vector3(-1298.96, -3406.27, 13.94 - 1), heading4 = 327.42, pedModel4 = "s_m_y_construct_02",}
        },

    },

    Mission = {
        PriceColis = 5000,
        Hydravion = {
            {spawnname = "dodo", spawnzone = vector3(-1282.15, -3380.17, 13.94), headingspawn = 330.01},
        },

        SAAirport = {
            {spawnname = "Nimbus", spawnzone = vector3(-1282.15, -3380.17, 13.94), headingspawn = 330.01, depotNPC = vector3(1703.27, 3250.16, 40.98)},
        },

        CayoAirport = {
            {spawnname = "miljet", spawnzone = vector3(-1275.37, -3387.38, 13.94), headingspawn = 150.77, depotNPCCayo = vector3(4480.96, -4497.38, 4.19)},
        },
    }

}


