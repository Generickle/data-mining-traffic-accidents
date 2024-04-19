# Adding libraries
install.packages("readxl")
install.packages("haven")
install.packages("arules")
install.packages("ggplot2")
install.packages("rpart")
install.packages("rpart.plot")

library(readxl)
library(haven)
library(arules)
library(ggplot2)
library(rpart)
library(rpart.plot)

# Get current working directory
getwd()

# Set working directory
setwd("/Users/macbookpro/Developer/GitHub/Generickle/data-mining-traffic-accidents")

# Verify access to files
list.files("data")

# Loading data
data_2015 <- read_excel("data/fflzORJDQM0tVur8UvU6fz5dR51kogHr.xlsx")
data_2016 <- read_excel("data/MVtI7adfQzZWF5uefXZ4xmZVG0vRik3S.xlsx")
data_2017 <- read_excel("data/201806191110218FciGNFOtT2FJnkTOS0pTzPcDOW8FpLB.xlsx")
data_2018 <- read_excel("data/20190606220307YRSvO7OHib0rQxKDCTAl2fkXMl05g9Uz.xlsx")
data_2019 <- read_excel("data/20200519181155Y1KZ2HK3GnWnOvCP6lkZunmf8PiHYFSH.xlsx")
data_2020 <- read_excel("data/20210531230635e7G5K5EZOlGPCBiH4ROtQRgfm5sTifW1.xlsx")
data_2021 <- read_excel("data/20230911222436xaPevkVgXaNin0L0ZmXiN4fm18JAFoLG.xlsx")
data_2022 <- read_excel("data/20230526200007YRSvO7OHib0rQxKDCTAl2fkXMl05g9Uz.xlsx")
data_2023 <- read_excel("data/20231212173715Yd6FWtyVWNULqHYzwTiXcRaLAl8B8jul.xlsx")
data_sav_1 <- read_sav("data/0NGWpC89u7XxdYqecRmMtNfW9uU9Npxc.sav")
data_sav_2 <- read_sav("data/DX2BmYU5m4JfPRhrFHwDRDEs49V7fN5I.sav")
data_sav_3 <- read_sav("data/gPTFUNJBcdfc5quaJizKEgBWvpjHBM70.sav")
data_sav_4 <- read_sav("data/JHtnT62UiTxEP6AbhA4RcFDN6Nokk4c9.sav")
data_sav_5 <- read_sav("data/LWRcgzU2wzY2XMCyCmupjEFTYoSZiWGy.sav")
data_sav_6 <- read_sav("data/xpN37xrHYYECLYQyVq7EiklsaibU3DM0.sav")

# Explore data
head(data_2015)
head(data_2016)
head(data_2017)
head(data_2018)
head(data_2019)
head(data_2020)
head(data_2021)
head(data_2022)
head(data_2023)
head(data_sav_1)
head(data_sav_2)
head(data_sav_3)
head(data_sav_4)
head(data_sav_5)

# Association rules

# Select specific columns from dataset
data_2022_subset <- data_2022[, c("mes_ocu", "día_ocu", "hora_ocu", "día_sem_ocu",
                              "depto_ocu", "mupio_ocu", "zona_ocu", 
                              "sexo_per", "edad_per", "mayor_menor",
                              "tipo_veh", "marca_veh", "color_veh", "modelo_veh", 
                              "tipo_eve", "fall_les", "int_o_noint")]

data_2022_time_subset <- data_2022[, c("mes_ocu", "día_ocu", "hora_ocu", "día_sem_ocu",
                                       "tipo_eve", "fall_les", "int_o_noint")]

data_2022_location_subset <- data_2022[, c("depto_ocu", "mupio_ocu", "zona_ocu", 
                                       "tipo_eve", "fall_les", "int_o_noint")]

data_2022_people_subset <- data_2022[, c("sexo_per", "edad_per", "mayor_menor",
                                       "tipo_eve", "fall_les", "int_o_noint")]

data_2022_vehicle_subset <- data_2022[, c("tipo_veh", "marca_veh", "color_veh", "modelo_veh", 
                                       "tipo_eve", "fall_les", "int_o_noint")]

# Filter data
data_2022_location_subset_filtered <- data_2022_location_subset[data_2022_location_subset$depto_ocu == "Chiquimula", ]

# Apply Apriori algorithm
time_rules <- apriori(data_2022_time_subset, parameter = list(support = 0.1, confidence = 0.5))
location_rules <- apriori(data_2022_location_subset_filtered, parameter = list(support = 0.1, confidence = 0.5))
people_rules <- apriori(data_2022_people_subset, parameter = list(support = 0.1, confidence = 0.5))
vehicle_rules <- apriori(data_2022_vehicle_subset, parameter = list(support = 0.1, confidence = 0.5))

# Show rules
inspect(time_rules)
inspect(location_rules)
inspect(people_rules)
inspect(vehicle_rules)

# Cluster analysis

# Data dictionaries
month_dictionary <- c("Enero" = 1, "Febrero" = 2, "Marzo" = 3, "Abril" = 4,
                      "Mayo" = 5, "Junio" = 6, "Julio" = 7, "Agosto" = 8,
                      "Septiembre" = 9, "Octubre" = 10, "Noviembre" = 11, "Diciembre" = 12)

day_dictionary <- c("Lunes" = 1, "Martes" = 2, "Miercoles" = 3, "Jueves" = 4,
                    "Viernes" = 5, "Sabado" = 6, "Domingo" = 7)

event_dictionary <- c("Colisión" = 1, "Choque" = 2, "Vuelco" = 3, "Caída" = 4,
                      "Atropello" = 5, "Derrape" = 6, "Embarranco" = 7,
                      "Encuneto" = 8, "Ignorado" = 99)

status_dictionary <- c("Fallecido" = 1, "Lesionado" = 2, "Ignorado" = 3)

internal_dictionary <- c("Internado" = 1, "No internado" = 2, "Ignorado" = 9)

state_dictionary <- c("Guatemala" = 1, "El Progreso" = 2, "Sacatepéquez" = 3,
                      "Chimaltenango" = 4, "Escuintla" = 5, "Santa Rosa" = 6,
                      "Sololá" = 7, "Totonicapán" = 8, "Quetzaltenango" = 9,
                      "Suchitepéquez" = 10, "Retalhuleu" = 11, "San Marcos" = 12,
                      "Huehuetenango" = 13, "Quiché" = 14, "Baja Verapaz" = 15,
                      "Alta Verapaz" = 16, "Petén" = 17, "Izabal" = 18, "Zacapa" = 19,
                      "Chiquimula" = 20, "Jalapa" = 21, "Jutiapa" = 22)

city_dictionary <- c("Guatemala" = 101, "Santa Catarina Pinula" = 102, "San José Pinula" = 103,
                     "San José del Golfo" = 104, "Palencia" = 105, "Chinautla" = 106, "San Pedro Ayampuc" = 107,
                     "Mixco" = 108, "San Pedro Sacatepéquez" = 109, "San Juan Sacatepéquez" = 110, "San Raymundo" = 111,
                     "Chuarrancho" = 112, "Fraijanes" = 113, "Amatitlán" = 114, "Villa Nueva" = 115, "Villa Canales" = 116,
                     "Petapa" = 117, "Guastatoya" = 201, "Morazán" = 202, "San Agustín Acasaguastlán" = 203,
                     "San Cristóbal Acasaguastlán" = 204, "El Jícaro" = 205, "Sansare" = 206, "Sanarate" = 207,
                     "San Antonio la Paz" = 208, "Antigua Guatemala" = 301, "Jocotenango" = 302, "Pastores" = 303,
                     "Sumpango" = 304, "Santo Domingo Xenacoj" = 305, "Santiago Sacatepéquez" = 306,
                     "San Bartolomé Milpas Altas" = 307, "San Lucas Sacatepéquez" = 308, "Santa Lucía Milpas Altas" = 309,
                     "Magdalena Milpas Altas" = 310, "Santa María de Jesús" = 311, "Ciudad Vieja" = 312, "San Miguel Dueñas" = 313,
                     "San Juan Alotenango" = 314, "San Antonio Aguas Calientes" = 315, "Santa Catarina Barahona" = 316,
                     "Chimaltenango" = 401, "San José  Poaquíl" = 402, "San Martín Jilotepeque" = 403, "Comalapa" = 404,
                     "Santa Apolonia" = 405, "Tecpán Guatemala" = 406, "Patzún" = 407, "San Miguel Pochuta" = 408,
                     "Patzicía" = 409, "Santa Cruz Balanyá" = 410, "Acatenango" = 411, "Yepocapa" = 412,
                     "San Andrés Itzapa" = 413, "Parramos" = 414, "Zaragoza" = 415, "El Tejar" = 416, "Escuintla" = 501,
                     "Santa Lucía Cotzumalguapa" = 502, "La Democracia" = 503, "Siquinalá" = 504, "Masagua" = 505,
                     "Tiquisate" = 506, "La Gomera" = 507, "Guanagazapa" = 508, "San José" = 509, "Iztapa" = 510, "Palín" = 511,
                     "San Vicente Pacaya" = 512, "Nueva Concepción" = 513, "Sipacate" = 514, "Cuilapa" = 601, "Barberena" = 602,
                     "Santa Rosa de Lima" = 603, "Casillas" = 604, "San Rafael las Flores" = 605, "Oratorio" = 606,
                     "San Juan Tecuaco" = 607, "Chiquimulilla" = 608, "Taxisco" = 609, "Santa María Ixhuatán" = 610,
                     "Guazacapán" = 611, "Santa Cruz el Naranjo" = 612, "Pueblo Nuevo Viñas" = 613, "Nueva Santa Rosa" = 614,
                     "Sololá" = 701, "San José Chacayá" = 702, "Santa María Visitación" = 703, "Santa Lucía Utatlán" = 704,
                     "Nahualá" = 705, "Santa Catarina Ixtahuacán" = 706, "Santa Clara la Laguna" = 707, "Concepción" = 708,
                     "San Andrés Semetabaj" = 709, "Panajachel" = 710, "Santa Catarina Palopó" = 711, "San Antonio Palopó" = 712,
                     "San Lucas Tolimán" = 713, "Santa Cruz la Laguna" = 714, "San Pablo la Laguna" = 715,
                     "San Marcos la Laguna" = 716, "San Juan la Laguna" = 717, "San Pedro la Laguna" = 718,
                     "Santiago Atitlán" = 719, "Totonicapán" = 801, "San Cristóbal Totonicapán" = 802,
                     "San Francisco el Alto" = 803, "San Andrés Xecul" = 804, "Momostenango" = 805,
                     "Santa María Chiquimula" = 806, "Santa Lucía la Reforma" = 807, "San Bartolo Aguas Calientes" = 808,
                     "Quetzaltenango" = 901, "Salcajá" = 902, "Olintepeque" = 903, "San Carlos Sija" = 904, "Sibilia" = 905,
                     "Cabricán" = 906, "Cajolá" = 907, "San Miguel Siguilá" = 908, "San Juan Ostuncalco" = 909,
                     "San Mateo" = 910, "Concepción Chiquirichapa" = 911, "San Martín Sacatepéquez" = 912, "Almolonga" = 913,
                     "Cantel" = 914, "Huitán" = 915, "Zunil" = 916, "Colomba" = 917, "San Francisco la Unión" = 918,
                     "El Palmar" = 919, "Coatepeque" = 920, "Génova" = 921, "Flores Costa Cuca" = 922, "La Esperanza" = 923,
                     "Palestina de los Altos" = 924, "Mazatenango" = 1001, "Cuyotenango" = 1002,
                     "San Francisco Zapotitlán" = 1003, "San Bernardino" = 1004, "San José el Ídolo" = 1005,
                     "Santo Domingo Suchitepéquez" = 1006, "San Lorenzo" = 1007, "Samayac" = 1008, "San Pablo Jocopilas" = 1009,
                     "San Antonio Suchitepéquez" = 1010, "San Miguel Panán" = 1011, "San Gabriel" = 1012, "Chicacao" = 1013,
                     "Patulul" = 1014, "Santa Bárbara" = 1015, "San Juan Bautista" = 1016, "Santo Tomas la Unión" = 1017,
                     "Zunilito" = 1018, "Pueblo Nuevo" = 1019, "Río Bravo" = 1020, "San José La Máquina" = 1021,
                     "Retalhuleu" = 1101, "San Sebastián" = 1102, "Santa Cruz Muluá" = 1103, "San Martín Zapotitlán" = 1104,
                     "San Felipe Retalhuleu" = 1105, "San Andrés Villa Seca" = 1106, "Champerico" = 1107,
                     "Nuevo San Carlos" = 1108, "El Asintal" = 1109, "San Marcos" = 1201, "San Pedro Sacatepéquez" = 1202,
                     "San Antonio Sacatepéquez" = 1203, "Comitancillo" = 1204, "San Miguel Ixtahuacán" = 1205,
                     "Concepción Tutuapa" = 1206, "Tacaná" = 1207, "Sibinal" = 1208, "Tajumulco" = 1209, "Tejutla" = 1210,
                     "San Rafael Pie de la Cuesta" = 1211, "Nuevo Progreso" = 1212, "El Tumbador" = 1213, "El Rodeo" = 1214,
                     "Malacatán" = 1215, "Catarina" = 1216, "Ayutla" = 1217, "Ocós" = 1218, "San Pablo" = 1219,
                     "El Quetzal" = 1220, "La Reforma" = 1221, "Pajapita" = 1222, "Ixchiguán" = 1223, "San José Ojetenam" = 1224,
                     "San Cristóbal Cucho" = 1225, "Sipacapa" = 1226, "Esquipulas Palo Gordo" = 1227, "Río Blanco" = 1228,
                     "San Lorenzo" = 1229, "La Blanca" = 1230, "Huehuetenango" = 1301, "Chiantla" = 1302, "Malacatancito" = 1303,
                     "Cuilco" = 1304, "Nentón" = 1305, "San Pedro Necta" = 1306, "Jacaltenango" = 1307,
                     "San Pedro Soloma" = 1308, "San Ildefonso Ixtahuacán" = 1309, "Santa Bárbara" = 1310, "La Libertad" = 1311,
                     "La Democracia" = 1312, "San Miguel Acatán" = 1313, "San Rafael La Independencia" = 1314,
                     "Todos Santos Cuchumatán" = 1315, "San Juan Atitán" = 1316, "Santa Eulalia" = 1317,
                     "San Mateo Ixtatán" = 1318, "Colotenango" = 1319, "San Sebastián Huehuetenango" = 1320, "Tectitán" = 1321,
                     "Concepción Huista" = 1322, "San Juan Ixcoy" = 1323, "San Antonio Huista" = 1324,
                     "San Sebastián Coatán" = 1325, "Barrillas" = 1326, "Aguacatán" = 1327, "San Rafael Petzal" = 1328,
                     "San Gaspar Ixchil" = 1329, "Santiago Chimaltenango" = 1330, "Santa Ana Huista" = 1331,
                     "Unión Cantinil" = 1332, "Petatán" = 1333, "Santa Cruz del Quiché" = 1401, "Chiché" = 1402,
                     "Chinique" = 1403, "Zacualpa" = 1404, "Chajul" = 1405, "Chichicastenango" = 1406, "Patzité" = 1407,
                     "San Antonio Ilotenango" = 1408, "San Pedro Jocopilas" = 1409, "Cunén" = 1410, "San Juan Cotzal" = 1411,
                     "Joyabaj" = 1412, "Santa María Nebaj" = 1413, "San Andrés Sajcabajá" = 1414, "San Miguel Uspantán" = 1415,
                     "Sacapulas" = 1416, "San Bartolomé Jocotenango" = 1417, "Canillá" = 1418, "Chicamán" = 1419,
                     "Ixcán" = 1420, "Pachalum" = 1421, "Salamá" = 1501, "San Miguel Chicaj" = 1502, "Rabinal" = 1503,
                     "Cubulco" = 1504, "Granados" = 1505, "El Chol" = 1506, "San Jerónimo" = 1507, "Purulhá" = 1508,
                     "Cobán" = 1601, "Santa Cruz Verapaz" = 1602, "San Cristóbal Verapaz" = 1603, "Tactic" = 1604,
                     "Tamahú" = 1605, "Tucurú" = 1606, "Panzós" = 1607, "Senahú" = 1608, "San Pedro Carchá" = 1609,
                     "San Juan Chamelco" = 1610, "Lanquín" = 1611, "Cahabón" = 1612, "Chisec" = 1613, "Chahal" = 1614,
                     "Fray Bartolomé de las Casas" = 1615, "Santa Catarina La Tinta" = 1616, "Raxruhá" = 1617,
                     "Flores" = 1701, "San José" = 1702, "San Benito" = 1703, "San Andrés" = 1704, "La Libertad" = 1705,
                     "San Francisco" = 1706, "Santa Ana" = 1707, "Dolores" = 1708, "San Luis" = 1709, "Sayaxché" = 1710,
                     "Melchor de Mencos" = 1711, "Poptún" = 1712, "Las Cruces" = 1713, "El Chal" = 1714,
                     "Puerto Barrios" = 1801, "Livingston" = 1802, "El Estor" = 1803, "Morales" = 1804, "Los Amates" = 1805,
                     "Zacapa" = 1901, "Estanzuela" = 1902, "Río Hondo" = 1903, "Gualán" = 1904, "Teculután" = 1905,
                     "Usumatlán" = 1906, "Cabañas" = 1907, "San Diego" = 1908, "La Unión" = 1909, "Huité" = 1910,
                     "San Jorge" = 1911, "Chiquimula" = 2001, "San José la Arada" = 2002, "San Juan Ermita" = 2003,
                     "Jocotán" = 2004, "Camotán" = 2005, "Olopa" = 2006, "Esquipulas" = 2007, "Concepción las Minas" = 2008,
                     "Quezaltepeque" = 2009, "San Jacinto" = 2010, "Ipala" = 2011, "Jalapa" = 2101, "San Pedro Pinula" = 2102,
                     "San Luis Jilotepeque" = 2103, "San Manuel Chaparrón" = 2104, "San Carlos Alzatate" = 2105,
                     "Monjas" = 2106, "Mataquescuintla" = 2107, "Jutiapa" = 2201, "El Progreso" = 2202,
                     "Santa Catarina Mita" = 2203, "Agua Blanca" = 2204, "Asunción Mita" = 2205, "Yupiltepeque" = 2206,
                     "Atescatempa" = 2207, "Jerez" = 2208, "El Adelanto" = 2209, "Zapotitlán" = 2210, "Comapa" = 2211,
                     "Jalpatagua" = 2212, "Conguaco" = 2213, "Moyuta" = 2214, "Pasaco" = 2215, "San José Acatempa" = 2216,
                     "Quesada" = 2217)

sex_dictionary = c("Hombre" = 1, "Mujer" = 2, "Ignorado" = 9)

age_dictionary = c("Mayor" = 1, "Menor" = 2, "Ignorado" = 9)

vehicle_type_dictionary = c("Automóvil" = 1, "Camioneta" = 2, "Pick up" = 3, "Motocicleta" = 4,
                       "Camión" = 5, "Cabezal" = 6, "Bus extraurbano" = 7, "Jeep" = 8, "Microbús" = 9,
                       "Taxi" = 10, "Panel" = 11, "Bus urbano" = 12, "Tractor" = 13, "Moto taxi" = 14,
                       "Furgón" = 15, "Grúa" = 16, "Bus escolar" = 17, "Bicicleta" = 18, "Avioneta" = 19,
                       "Montacargas" = 20, "Bus militar" = 21, "Cuatrimoto" = 22, "Furgoneta" = 23,
                       "Motos acuáticas" = 24, "Ignorado" = 99)

vehicle_brand_dictionary = c("AHM" = 1, "TVS Apache" = 2, "Asia Hero" = 3, "Audi" = 4, "Avanti" = 5, "Bajaj" = 6,
                             "Blue Bird" = 7, "BMW" = 8, "Changan" = 9, "Chevrolet" = 10, "Chrysler" = 11, "Daewoo" = 12,
                             "Daihatsu" = 13, "Datsun" = 14, "Dodge" = 15, "Fiat" = 16, "Ford" = 17, "Freedom" = 18,
                             "Freightliner" = 19, "Genesis" = 20, "Geo" = 21, "Alfa Romeo" = 22, "GMC" = 23, "Great Wall" = 24,
                             "Hero Hunk" = 25, "Hino" = 26, "Honda" = 27, "Hyundai" = 28, "Infiniti" = 29, "Internacional" = 30,
                             "Isuzu" = 31, "Italika" = 32, "Jaguar" = 33, "Jeep" = 34, "Jialing" = 35, "John Deere" = 36,
                             "Jumbo" = 37, "Kawasaki" = 38, "Keeway" = 39, "Kenworth" = 40, "Kia" = 41, "Kinlon" = 42,
                             "Kymco" = 43, "Land Rover" = 44, "Loncin" = 45, "Mahindra" = 46, "Lexus" = 47, "Mazda" = 48,
                             "MCI" = 49, "Mercedes Benz" = 50, "Mini Cooper" = 51, "Mitsubishi" = 52, "Motolansa" = 53,
                             "Movesa" = 54, "Porche" = 55, "Nissan" = 56, "Peter Bilt" = 57, "Peugeot" = 58, "Piaggio" = 59,
                             "Plymouth" = 60, "Renault" = 61, "Rhino" = 62, "Sanyang" = 63, "Serpento" = 64, "Soprano" = 65,
                             "Subaru" = 66, "Suzuki" = 67, "Sym" = 68, "Toyota" = 69, "Cadillac" = 70, "Harley Davidson" = 71,
                             "United Motors (UM)" = 72, "Volkswagen" = 73, "Volvo" = 74, "Wuling" = 75, "Yamaha" = 76,
                             "Yumbo dakar" = 77, "Ferrari" = 78, "Seat" = 79, "Autoriksha" = 80, "Eagle flight" = 81,
                             "Honlei" = 83, "Jac" = 84, "Jinbei" = 85, "Hummer" = 86, "X-bow KRM" = 87, "Mack" = 88,
                             "Pontiac" = 89, "Scion" = 90, "ZX auto" = 91, "Sterling" = 92, "Yiben" = 93, "Ritchie Bros" = 94,
                             "Chery Destiny" = 95, "Vento" = 96, "Citroen" = 97, "Dayun" = 98, "JMC" = 99, "Haojue" = 100,
                             "Hyosung" = 101, "Jincheng" = 102, "Lifan" = 103, "Macat" = 104, "Pegasus" = 105,
                             "Rolls Royse" = 106, "Acura" = 107, "Kingo" = 108, "Raybar" = 109, "Regent" = 110, "Sing" = 111,
                             "Shineray" = 112, "Skigo" = 113, "Tough" = 114, "Wuyang" = 115, "Caterpillar" = 116,
                             "Opel" = 117, "Scrambler" = 118, "Mercury" = 119, "Saturn Corporation" = 120, "BYD" = 121,
                             "Lincoln" = 122, "Shimano" = 123, "Vecesa" = 124, "Dayang" = 125, "Dinamo" = 126, "DPV Dover" = 127,
                             "FAW Jiabao" = 128, "Fisher" = 129, "Frontier" = 130, "Makiba" = 131, "Motinsa" = 132,
                             "Kinroad" = 133, "Qingqi" = 134, "Transmetro" = 135, "Wanfeng" = 136, "Cadisa" = 137,
                             "Ssangyong" = 138, "Daelim" = 139, "Bashan" = 140, "Zongshen" = 141, "Sukida" = 142,
                             "Chongqing" = 143, "Foton" = 144, "Chana" = 145, "Prymouth" = 146, "Aprilia" = 147,
                             "Fastran" = 148, "Skoda" = 149, "Mustang" = 150, "Geely" = 151, "Daifo" = 152, "Workman" = 153,
                             "Forward" = 154, "King long" = 155, "Automosa" = 156, "GAC Gonow" = 157, "Ud Trucks" = 158,
                             "Scania" = 159, "New Holland" = 160, "Freeway" = 161, "Keiko" = 162, "Benelli" = 163,
                             "Jetix" = 164, "TMR SL" = 165, "Ape City" = 166, "Brigadier" = 167, "MRT" = 168,
                             "Oldsmobile" = 169, "KTM" = 170, "BMX" = 171, "Senke" = 172, "CF Moto" = 173, "Busscar" = 174,
                             "Sinotruk" = 175, "Sanlg" = 176, "Jiangsu sinki" = 177, "Berliet" = 178, "Aurus Senat" = 179,
                             "Fruehauf" = 180, "Kioti" = 181, "Maya tour" = 182, "Sanya" = 183, "Triumph" = 184,
                             "Kenton" = 185, "Skygo" = 186, "Great Dane" = 187, "Phenix" = 188, "Segway" = 189, "Otros" = 190,
                             "Ignorado" = 999)

vehicle_color_dictionary <- c("Rojo" = 1, "Blanco" = 2, "Azul" = 3, "Gris" = 4, "Negro" = 5,
                              "Verde" = 6, "Amarillo" = 7, "Celeste" = 8, "Corinto" = 9, "Café" = 10,
                              "Beige" = 11,"Turquesa" = 12, "Marfil" = 13, "Anaranjado" = 14, "Morado" = 15,
                              "Rosado" = 16, "Varios colores" = 17, "Ignorado" = 99)

# Transform data
data_2022_subset_transformed <- data_2022_subset

data_2022_subset_transformed$mes_ocu <- month_dictionary[data_2022_subset$mes_ocu]
data_2022_subset_transformed$día_sem_ocu <- day_dictionary[data_2022_subset$día_sem_ocu]
data_2022_subset_transformed$tipo_eve <- event_dictionary[data_2022_subset$tipo_eve]
data_2022_subset_transformed$fall_les <- status_dictionary[data_2022_subset$fall_les]
data_2022_subset_transformed$int_o_noint <- internal_dictionary[data_2022_subset$int_o_noint]
data_2022_subset_transformed$depto_ocu <- state_dictionary[data_2022_subset$depto_ocu]
data_2022_subset_transformed$mupio_ocu <- city_dictionary[data_2022_subset$mupio_ocu]
data_2022_subset_transformed$sexo_per <- sex_dictionary[data_2022_subset$sexo_per]
data_2022_subset_transformed$mayor_menor <- age_dictionary[data_2022_subset$mayor_menor]
data_2022_subset_transformed$tipo_veh <- vehicle_type_dictionary[data_2022_subset$tipo_veh]
data_2022_subset_transformed$marca_veh <- vehicle_brand_dictionary[data_2022_subset$marca_veh]
data_2022_subset_transformed$color_veh <- vehicle_color_dictionary[data_2022_subset$color_veh]

# Describe transformed data
str(data_2022_subset_transformed)

# Remove N/A records
data_2022_subset_transformed <- na.omit(data_2022_subset_transformed)

# Filter data
data_2022_subset_transformed <- data_2022_subset_transformed[data_2022_subset_transformed$tipo_eve != 99, ]
data_2022_subset_transformed <- data_2022_subset_transformed[data_2022_subset_transformed$zona_ocu != "Ignorado", ]
data_2022_subset_transformed <- data_2022_subset_transformed[data_2022_subset_transformed$edad_per != "Ignorada", ]
data_2022_subset_transformed <- data_2022_subset_transformed[data_2022_subset_transformed$modelo_veh != "Ignorado", ]

# Select specific columns from transformed dataset
data_2022_time_subset_transformed <- data_2022_subset_transformed[, c("mes_ocu", "día_ocu", "hora_ocu", "día_sem_ocu",
                                                                  "tipo_eve", "fall_les", "int_o_noint")]

data_2022_location_subset_transformed <- data_2022_subset_transformed[, c("depto_ocu", "mupio_ocu", "zona_ocu", 
                                                                     "tipo_eve", "fall_les", "int_o_noint")]

data_2022_people_subset_transformed <- data_2022_subset_transformed[, c("sexo_per", "edad_per", "mayor_menor",
                                                                   "tipo_eve", "fall_les", "int_o_noint")]

data_2022_vehicle_subset_transformed <- data_2022_subset_transformed[, c("tipo_veh", "marca_veh", "color_veh", "modelo_veh", 
                                                                    "tipo_eve", "fall_les", "int_o_noint")]

# Apply K-means algorithm
clusters <- kmeans(data_2022_subset_transformed, centers = 2)
time_clusters <- kmeans(data_2022_time_subset_transformed, centers = 2)
location_clusters <- kmeans(data_2022_location_subset_transformed, centers = 2)
people_clusters <- kmeans(data_2022_people_subset_transformed, centers = 2)
vehicle_clusters <- kmeans(data_2022_vehicle_subset_transformed, centers = 2)

# Graphic clusters
ggplot(data_2022_subset_transformed, aes(x = mes_ocu , y = tipo_eve , color = as.factor(clusters$cluster))) +
  geom_point() + 
  geom_point(data = as.data.frame(clusters$centers), aes(x = mes_ocu, y = tipo_eve), color = "black", size = 4, shape = 17) +
  labs(title = "Mes del accidente vs tipo de evento") +
  theme_minimal()

ggplot(data_2022_subset_transformed, aes(x = depto_ocu , y = tipo_eve , color = as.factor(clusters$cluster))) +
  geom_point() + 
  geom_point(data = as.data.frame(clusters$centers), aes(x = depto_ocu, y = tipo_eve), color = "black", size = 4, shape = 17) +
  labs(title = "Departamento del accidente vs tipo de evento") +
  theme_minimal()

ggplot(data_2022_subset_transformed, aes(x = sexo_per , y = tipo_eve , color = as.factor(clusters$cluster))) +
  geom_point() + 
  geom_point(data = as.data.frame(clusters$centers), aes(x = sexo_per, y = tipo_eve), color = "black", size = 4, shape = 17) +
  labs(title = "Género del involucrado vs tipo de evento") +
  theme_minimal()

ggplot(data_2022_subset_transformed, aes(x = tipo_veh , y = tipo_eve , color = as.factor(clusters$cluster))) +
  geom_point() + 
  geom_point(data = as.data.frame(clusters$centers), aes(x = tipo_veh, y = tipo_eve), color = "black", size = 4, shape = 17) +
  labs(title = "Tipo de vehículo vs tipo de evento") +
  theme_minimal()

ggplot(data_2022_time_subset_transformed, aes(x = mes_ocu , y = tipo_eve , color = as.factor(time_clusters$cluster))) +
  geom_point() + 
  geom_point(data = as.data.frame(time_clusters$centers), aes(x = mes_ocu, y = tipo_eve), color = "black", size = 4, shape = 17) +
  labs(title = "Mes del accidente vs tipo de evento") +
  theme_minimal()

ggplot(data_2022_location_subset_transformed, aes(x = depto_ocu , y = tipo_eve , color = as.factor(location_clusters$cluster))) +
  geom_point() + 
  geom_point(data = as.data.frame(location_clusters$centers), aes(x = depto_ocu, y = tipo_eve), color = "black", size = 4, shape = 17) +
  labs(title = "Departamento del accidente vs tipo de evento") +
  theme_minimal()

ggplot(data_2022_people_subset_transformed, aes(x = sexo_per , y = tipo_eve , color = as.factor(people_clusters$cluster))) +
  geom_point() + 
  geom_point(data = as.data.frame(people_clusters$centers), aes(x = sexo_per, y = tipo_eve), color = "black", size = 4, shape = 17) +
  labs(title = "Género del involucrado vs tipo de evento") +
  theme_minimal()

ggplot(data_2022_vehicle_subset_transformed, aes(x = tipo_veh , y = tipo_eve , color = as.factor(vehicle_clusters$cluster))) +
  geom_point() + 
  geom_point(data = as.data.frame(vehicle_clusters$centers), aes(x = tipo_veh, y = tipo_eve), color = "black", size = 4, shape = 17) +
  labs(title = "Tipo de vehículo vs tipo de evento") +
  theme_minimal()

# Classification

# Building trees
general_time_tree <- rpart(tipo_eve ~ mes_ocu + día_ocu + hora_ocu + día_sem_ocu + fall_les + int_o_noint,
                           data = data_2022_subset_transformed,
                           method = "class")

general_location_tree <- rpart(tipo_eve ~ depto_ocu + mupio_ocu + zona_ocu + fall_les + int_o_noint,
                               data = data_2022_subset_transformed,
                               method = "class")

general_people_tree <- rpart(tipo_eve ~ sexo_per + edad_per + mayor_menor + fall_les + int_o_noint,
                             data = data_2022_subset_transformed,
                             method = "class")

general_vehicle_tree <- rpart(tipo_eve ~ tipo_veh + marca_veh + color_veh + modelo_veh + fall_les + int_o_noint,
                              data = data_2022_subset_transformed,
                              method = "class")

time_tree <- rpart(tipo_eve ~ mes_ocu + día_ocu + hora_ocu + día_sem_ocu + fall_les + int_o_noint,
                   data = data_2022_time_subset_transformed,
                   method = "class")

location_tree <- rpart(tipo_eve ~ depto_ocu + mupio_ocu + zona_ocu + fall_les + int_o_noint,
                   data = data_2022_location_subset_transformed,
                   method = "class")

people_tree <- rpart(tipo_eve ~ sexo_per + edad_per + mayor_menor + fall_les + int_o_noint,
                   data = data_2022_people_subset_transformed,
                   method = "class")

vehicle_tree <- rpart(tipo_eve ~ tipo_veh + marca_veh + color_veh + modelo_veh + fall_les + int_o_noint,
                   data = data_2022_vehicle_subset_transformed,
                   method = "class")

# Construir el modelo de árbol de decisiones
modelo_arbol_tiempo <- rpart(fall_les ~ tipo_veh + sexo_per + depto_ocu,
                             data = data_2022_subset_transformed)

# Visualizar el árbol de decisiones
rpart.plot(modelo_arbol_tiempo,
           box.palette = "RdBu",
           shadow.col = "gray",
           nn = TRUE)

test_tree <- rpart(sexo_per ~ edad_per,
                           data = data_2022_subset_transformed,
                           method = "class")

# Graphic tree
rpart.plot(test_tree,
           type = 2,
           extra = 0,  
           under = TRUE,  
           fallen.leaves = TRUE,
           box.palette = "BuGn",  
           main = "Test 2",
           cex = 0.45)

rpart.plot(general_time_tree,
           type = 2,
           extra = 0,  
           under = TRUE,  
           fallen.leaves = TRUE,
           box.palette = "BuGn",  
           main = "Tipo de evento dada la fecha, hora y diagnóstico",
           cex = 0.45)

rpart.plot(general_location_tree,
           type = 2,
           extra = 0,  
           under = TRUE,  
           fallen.leaves = TRUE,
           box.palette = "BuGn",  
           main = "Tipo de evento dada la ubicación y diagnóstico",
           cex = 0.45)

rpart.plot(general_people_tree,
           type = 2,
           extra = 0,  
           under = TRUE,  
           fallen.leaves = TRUE,
           box.palette = "BuGn",  
           main = "Tipo de evento dado el género, edad y diagnóstico",
           cex = 0.45)

rpart.plot(general_vehicle_tree,
           type = 2,
           extra = 0,  
           under = TRUE,  
           fallen.leaves = TRUE,
           box.palette = "BuGn",  
           main = "Tipo de evento dado el vehículo y diagnóstico",
           cex = 0.45)

rpart.plot(time_tree,
           type = 2,
           extra = 0,  
           under = TRUE,  
           fallen.leaves = TRUE,
           box.palette = "BuGn",  
           main = "Tipo de evento dada la fecha, hora y diagnóstico",
           cex = 0.45)

rpart.plot(location_tree,
           type = 2,
           extra = 0,  
           under = TRUE,  
           fallen.leaves = TRUE,
           box.palette = "BuGn",  
           main = "Tipo de evento dada la ubicación y diagnóstico",
           cex = 0.45)

rpart.plot(people_tree,
           type = 2,
           extra = 0,  
           under = TRUE,  
           fallen.leaves = TRUE,
           box.palette = "BuGn",  
           main = "Tipo de evento dado el género, edad y diagnóstico",
           cex = 0.45)

rpart.plot(vehicle_tree,
           type = 2,
           extra = 0,  
           under = TRUE,  
           fallen.leaves = TRUE,
           box.palette = "BuGn",  
           main = "Tipo de evento dado el vehículo y diagnóstico",
           cex = 0.45)

# Creating nodes to evaluate
time_data <- data.frame(
  mes_ocu = c(1),
  día_ocu = c(1),
  hora_ocu = c(1),
  día_sem_ocu = c(1),
  fall_les = c(1),
  int_o_noint = c(1)
)

location_data <- data.frame(
  depto_ocu=c(1),
  fall_les = c(1),
  int_o_noint = c(1)
)

people_data <- data.frame(
  sexo_per=c(1),
  fall_les = c(1),
  int_o_noint = c(1)
)

vehicle_data <- data.frame(
  depto_ocu=c(1),
  fall_les = c(1),
  int_o_noint = c(1)
)

# Prediction
general_time_prediction <- predict(general_time_tree, new_data, type ="class")
general_location_prediction <- predict(general_location_tree, new_data, type ="class")
general_people_prediction <- predict(general_people_tree, new_data, type ="class")
general_vehicle_prediction <- predict(general_vehicle_tree, new_data, type ="class")

time_prediction <- predict(time_tree, new_data, type ="class")
location_prediction <- predict(location_tree, new_data, type ="class")
people_prediction <- predict(people_tree, new_data, type ="class")
vehicle_prediction <- predict(vehicle_tree, new_data, type ="class")

# Show prediction
print(general_time_prediction)
print(general_location_prediction)
print(general_people_prediction)
print(general_vehicle_prediction)

print(time_prediction)
print(location_prediction)
print(people_prediction)
print(vehicle_prediction)