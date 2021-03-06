class InserirDadosDasUnidadesOrganicas < ActiveRecord::Migration[5.1]
  def change

    posto           = EstablishmentType.create(name: 'Posto')
    dependencia     = EstablishmentType.create(name: 'Dependência')
    centro          = EstablishmentType.create(name: 'Centro')
    agencia         = EstablishmentType.create(name: 'Agência')
    caixa_avancado  = EstablishmentType.create(name: 'Caixa Avançado')



    agencias = [
      {establishment_type_id: agencia.id, code: "101", abbreviation: "NCD", name: "Agência de Cabinda - Cabinda"},
      {establishment_type_id: agencia.id, code: "201", abbreviation: "NUI", name: "Agência do Uíge - Uige"},
      {establishment_type_id: agencia.id, code: "301", abbreviation: "NSO", name: "Agência do Soyo - Zaire"},
      {establishment_type_id: agencia.id, code: "401", abbreviation: "NND", name: "Agência de Ndalatando - Cuanza - Norte"},
      {establishment_type_id: agencia.id, code: "520", abbreviation: "NES", name: "Agência Edificio Sol - Luanda"},
      {establishment_type_id: agencia.id, code: "601", abbreviation: "NQI", name: "Agência da Quibala - Lunda - Sul"},
      {establishment_type_id: agencia.id, code: "701", abbreviation: "NCA", name: "Agência de Caxito - Bengo"},
      {establishment_type_id: agencia.id, code: "801", abbreviation: "NDU", name: "Agência do Dundo -  Lunda Norte"},
      {establishment_type_id: agencia.id, code: "901", abbreviation: "NSA", name: "Agência do Saurimo - Cuanza - Sul"},
      {establishment_type_id: agencia.id, code: "1101", abbreviation: "NLB", name: "Agência do Lobito - Benguela"},
      {establishment_type_id: agencia.id, code: "1102", abbreviation: "NBE", name: "Agência de Benguela - Benguela"},
      {establishment_type_id: agencia.id, code: "1201", abbreviation: "NHB", name: "Agência do Huambo - Huambo"},
      {establishment_type_id: agencia.id, code: "1301", abbreviation: "NKT", name: "Agência do Kuito - Bié"},
      {establishment_type_id: agencia.id, code: "1401", abbreviation: "NMX", name: "Agência do Moxico - Moxico"},
      {establishment_type_id: agencia.id, code: "1501", abbreviation: "NHA", name: "Agência da Huíla - Lubango"},
      {establishment_type_id: agencia.id, code: "1601", abbreviation: "NMB", name: "Agência do Namibe - Namibe"},
      {establishment_type_id: agencia.id, code: "1702", abbreviation: "NMG", name: "Agência de Menongue - Cuando - Cubango"},
      {establishment_type_id: agencia.id, code: "1801", abbreviation: "NON", name: "Agência de Ondjiva - Cunene"},
      {establishment_type_id: agencia.id, code: "1901", abbreviation: "NMA", name: "Agência de Malanje - Malanje"}
    ]

    dependencias = [
      {establishment_type_id: dependencia.id, code: "103", abbreviation: "ICD", name: "Dependência de Cabinda"},
      {establishment_type_id: dependencia.id, code: "110", abbreviation: "IFT", name: "Dependência de Fútila"},
      {establishment_type_id: dependencia.id, code: "204", abbreviation: "INE", name: "Dependência do Negage"},
      {establishment_type_id: dependencia.id, code: "209", abbreviation: "IMZ", name: "Dependência do Maquela do Zombo "},
      {establishment_type_id: dependencia.id, code: "303", abbreviation: "INZ", name: "Dependência do Nzeto"},
      {establishment_type_id: dependencia.id, code: "304", abbreviation: "IIM", name: "Dependência do INSS do Mbanza Congo"},
      {establishment_type_id: dependencia.id, code: "402", abbreviation: "IDO", name: "Dependência do Dondo"},
      {establishment_type_id: dependencia.id, code: "403", abbreviation: "ICT", name: "Dependência de Camabatela"},
      {establishment_type_id: dependencia.id, code: "501", abbreviation: "IKA", name: "Dependência da Katyavala"},
      {establishment_type_id: dependencia.id, code: "502", abbreviation: "IMT", name: "Dependência da Mutamba"},
      {establishment_type_id: dependencia.id, code: "503", abbreviation: "ICA", name: "Dependência do Cazenga"},
      {establishment_type_id: dependencia.id, code: "504", abbreviation: "ICR", name: "Dependência do Cruzeiro"},
      {establishment_type_id: dependencia.id, code: "505", abbreviation: "IBP", name: "Dependência do Bairro Popular"},
      {establishment_type_id: dependencia.id, code: "506", abbreviation: "ISP", name: "Dependência do São Paulo - FECHADO"},
      {establishment_type_id: dependencia.id, code: "507", abbreviation: "IAC", name: "Dependência de Amílcar Cabral"},
      {establishment_type_id: dependencia.id, code: "508", abbreviation: "IMB", name: "Dependência do Morro Bento -  FECHADO"},
      {establishment_type_id: dependencia.id, code: "509", abbreviation: "IAB", name: "Dependência do Américo Boavida"},
      {establishment_type_id: dependencia.id, code: "510", abbreviation: "IHM", name: "Dependência do Hospital Militar"},
      {establishment_type_id: dependencia.id, code: "511", abbreviation: "ILA", name: "Dependência da Liga Africana"},
      {establishment_type_id: dependencia.id, code: "512", abbreviation: "ICC", name: "Dependência de Cacuaco"},
      {establishment_type_id: dependencia.id, code: "513", abbreviation: "IRG", name: "Dependência da Rainha Ginga"},
      {establishment_type_id: dependencia.id, code: "514", abbreviation: "IVI", name: "Dependência de Viana"},
      {establishment_type_id: dependencia.id, code: "515", abbreviation: "IMC", name: "Dependência do Maculusso"},
      {establishment_type_id: dependencia.id, code: "516", abbreviation: "IMA", name: "Dependência do Marçal"},
      {establishment_type_id: dependencia.id, code: "517", abbreviation: "IMO", name: "Dependência do Morro Bento II"},
      {establishment_type_id: dependencia.id, code: "518", abbreviation: "IUC", name: "Dependência da Cuca"},
      {establishment_type_id: dependencia.id, code: "519", abbreviation: "IUA", name: "Dependência da Utanga"},
      {establishment_type_id: dependencia.id, code: "521", abbreviation: "IGS", name: "Dependência Ginga Shopping"},
      {establishment_type_id: dependencia.id, code: "522", abbreviation: "ICE", name: "Dependência Edel do Camama"},
      {establishment_type_id: dependencia.id, code: "523", abbreviation: "IDR", name: "Dependência da Avenida Deolinda Rodrigues"},
      {establishment_type_id: dependencia.id, code: "524", abbreviation: "IFE", name: "Dependência do Ferrovia"},
      {establishment_type_id: dependencia.id, code: "525", abbreviation: "ITH", name: "Dependência do Tala Hady"},
      {establishment_type_id: dependencia.id, code: "526", abbreviation: "IBF", name: "Dependência do Benfica"},
      {establishment_type_id: dependencia.id, code: "527", abbreviation: "IFU", name: "Dependência do Futungo"},
      {establishment_type_id: dependencia.id, code: "528", abbreviation: "ISB", name: "Dependência da Samba"},
      {establishment_type_id: dependencia.id, code: "529", abbreviation: "IUT", name: "Dependência da Mutamba II"},
      {establishment_type_id: dependencia.id, code: "530", abbreviation: "IGL", name: "Dependência da Marginal"},
      {establishment_type_id: dependencia.id, code: "531", abbreviation: "ILP", name: "Dependência do Lar Patriota"},
      {establishment_type_id: dependencia.id, code: "532", abbreviation: "IBE", name: "Dependência do Benfica II"},
      {establishment_type_id: dependencia.id, code: "533", abbreviation: "IVF", name: "Dependência Vereda das Flores"},
      {establishment_type_id: dependencia.id, code: "534", abbreviation: "ISI", name: "Dependência Simione (Camama) "},
      {establishment_type_id: dependencia.id, code: "535", abbreviation: "ISO", name: "Dependência Soba Capassa (Camama) "},
      {establishment_type_id: dependencia.id, code: "536", abbreviation: "IET", name: "Dependência do Edifício Talatona"},
      {establishment_type_id: dependencia.id, code: "537", abbreviation: "IJR", name: "Dependência do Jardim de Rosas"},
      {establishment_type_id: dependencia.id, code: "538", abbreviation: "INV", name: "Dependência do Nova Vida"},
      {establishment_type_id: dependencia.id, code: "539", abbreviation: "IGO", name: "Dependência do Golf II"},
      {establishment_type_id: dependencia.id, code: "540", abbreviation: "IUL", name: "Dependência do Centro Comercial Ulengo da SAPÚ"},
      {establishment_type_id: dependencia.id, code: "541", abbreviation: "IGK", name: "Dependência do Gamek"},
      {establishment_type_id: dependencia.id, code: "542", abbreviation: "IKB", name: "Dependência do Kaop Business Park"},
      {establishment_type_id: dependencia.id, code: "543", abbreviation: "ICN", name: "Dependência do Cacuaco Business Park"},
      {establishment_type_id: dependencia.id, code: "544", abbreviation: "IAH", name: "Dependência Avenida Hojy Ya Henda"},
      {establishment_type_id: dependencia.id, code: "545", abbreviation: "IWC", name: "Dependência do Complexo WTC"},
      {establishment_type_id: dependencia.id, code: "546", abbreviation: "IPM", name: "Dependência do Projecto Morar"},
      {establishment_type_id: dependencia.id, code: "547", abbreviation: "ICV", name: "Dependência do Condomínio Bela Vista"},
      {establishment_type_id: dependencia.id, code: "548", abbreviation: "IGC", name: "Dependência do Golf Center"},
      {establishment_type_id: dependencia.id, code: "549", abbreviation: "IVN", name: "Dependência do Condomínio Vila Nova (Talatona) "},
      {establishment_type_id: dependencia.id, code: "550", abbreviation: "ICK", name: "Dependência da Cidade do Kilamba"},
      {establishment_type_id: dependencia.id, code: "602", abbreviation: "IWK", name: "Dependência do Waku Kungo"},
      {establishment_type_id: dependencia.id, code: "604", abbreviation: "IMS", name: "Dependência do Mercado do Sumbe"},
      {establishment_type_id: dependencia.id, code: "606", abbreviation: "ISU", name: "Dependência do Sumbe"},
      {establishment_type_id: dependencia.id, code: "607", abbreviation: "IPA", name: "Dependência do Porto Amboím"},
      {establishment_type_id: dependencia.id, code: "702", abbreviation: "IAM", name: "Dependência do Ambriz"},
      {establishment_type_id: dependencia.id, code: "705", abbreviation: "IPN", name: "Dependência do Panguila"},
      {establishment_type_id: dependencia.id, code: "1103", abbreviation: "ICU", name: "Dependência do Cubal"},
      {establishment_type_id: dependencia.id, code: "1104", abbreviation: "ICB", name: "Dependência do Caminho de Ferro de Benguela"},
      {establishment_type_id: dependencia.id, code: "1106", abbreviation: "IMM", name: "Dependência do Mercado Municipal do Lobito"},
      {establishment_type_id: dependencia.id, code: "1107", abbreviation: "IBV", name: "Dependência da Bela Vista"},
      {establishment_type_id: dependencia.id, code: "1109", abbreviation: "IHC", name: "Dependência do Hospital Central de Benguela"},
      {establishment_type_id: dependencia.id, code: "1110", abbreviation: "IGA", name: "Dependência da Ganda"},
      {establishment_type_id: dependencia.id, code: "1112", abbreviation: "ILO", name: "Dependência do Porto do Lobito"},
      {establishment_type_id: dependencia.id, code: "1114", abbreviation: "ILI", name: "Dependência do Liro"},
      {establishment_type_id: dependencia.id, code: "1202", abbreviation: "IBA", name: "Dependência do Bailundo"},
      {establishment_type_id: dependencia.id, code: "1205", abbreviation: "ICI", name: "Dependência da Cidade Alta (Huambo)"},
      {establishment_type_id: dependencia.id, code: "1403", abbreviation: "ILE", name: "Dependência do Luena"},
      {establishment_type_id: dependencia.id, code: "1503", abbreviation: "ILU", name: "Dependência do Lubango (Stº António)"},
      {establishment_type_id: dependencia.id, code: "1504", abbreviation: "IMU", name: "Dependência do Mercado do Mutundo (Lubango)"},
      {establishment_type_id: dependencia.id, code: "1505", abbreviation: "IQP", name: "Dependência do Quipungo"},
      {establishment_type_id: dependencia.id, code: "1802", abbreviation: "ISC", name: "Dependência de Santa Clara"},
      {establishment_type_id: dependencia.id, code: "1902", abbreviation: "ICS", name: "Dependência de Cacuso"},
      {establishment_type_id: dependencia.id, code: "1903", abbreviation: "IMG", name: "Dependência de Malange"},
      {establishment_type_id: dependencia.id, code: "1908", abbreviation: "IMN", name: "Dependência do Massango"},
      {establishment_type_id: dependencia.id, code: "5003", abbreviation: "IAL", name: "Dependência Alfândega de Luanda"},
      {establishment_type_id: dependencia.id, code: "5006", abbreviation: "IPL", name: "Dependência do Porto de Luanda"},
      {establishment_type_id: dependencia.id, code: "5008", abbreviation: "IEC", name: "Dependência do Entreposto Aduaneiro"},
      {establishment_type_id: dependencia.id, code: "5009", abbreviation: "IHE", name: "Dependência das Heroínas - FECHADO"},
      {establishment_type_id: dependencia.id, code: "5010", abbreviation: "IBJ", name: "Depedência do Bom Jesus"},
      {establishment_type_id: dependencia.id, code: "5015", abbreviation: "IZG", name: "Dependência do Zango"}
    ]

    centros = [
      {establishment_type_id: centro.id, code: "2001", abbreviation: "CGEF", name: "Centro de Empresas – Ferrovia"},
      {establishment_type_id: centro.id, code: "2002", abbreviation: "CELA", name: "Centro de Empresas – Liga Africana"},
      {establishment_type_id: centro.id, code: "2003", abbreviation: "CEET", name: "Centro de Empresas – Edificio Talatona"},
      {establishment_type_id: centro.id, code: "2004", abbreviation: "CEMT", name: "Centro de Empresas - Mutamba"},
      {establishment_type_id: centro.id, code: "2005", abbreviation: "CEFE", name: "Centro de Empresas - Ferrovia"},
      {establishment_type_id: centro.id, code: "2006", abbreviation: "CEMI", name: "Centro de Empresas - Missão"},
      {establishment_type_id: centro.id, code: "2007", abbreviation: "CEGL", name: "Centro de Empresas - Marginal"},
      {establishment_type_id: centro.id, code: "2008", abbreviation: "CEOG", name: "Centro de Empresas - OIL & GAS"},
      {establishment_type_id: centro.id, code: "2009", abbreviation: "CEDR", name: "Centro de Empresas - Deolinda Rodrigues"},
      {establishment_type_id: centro.id, code: "2010", abbreviation: "CERH", name: "Centro de Empresas - Região Sul (Huíla)"},
      {establishment_type_id: centro.id, code: "2011", abbreviation: "CEVI", name: "Centro de Empresas - Viana"},
      {establishment_type_id: centro.id, code: "2012", abbreviation: "CEBE", name: "Centro de Empresas - Benfica II"},
      {establishment_type_id: centro.id, code: "2013", abbreviation: "CESO", name: "Centro de Empresas - Soba Capassa (Camama)"},
      {establishment_type_id: centro.id, code: "2014", abbreviation: "CELP", name: "Centro de Empresas – Lar do Patriota"},
      {establishment_type_id: centro.id, code: "2015", abbreviation: "CELO", name: "Centro de Empresas – Lobito"},
      {establishment_type_id: centro.id, code: "2016", abbreviation: "CESC", name: "Centro de Empresas – Santa Clara"},
      {establishment_type_id: centro.id, code: "2017", abbreviation: "CECB", name: "Centro de Empresas – Cacuaco Business Park"},
      {establishment_type_id: centro.id, code: "2018", abbreviation: "CECA", name: "Centro de Empresas – Cabinda"},
      {establishment_type_id: centro.id, code: "2020", abbreviation: "CEVA", name: "Centro de Empresas - Vila Alice"}
    ]

    postos = [
      {establishment_type_id: posto.id, code: "102", abbreviation: "PAC", name: "Posto da Alfândega de Cabinda (Porto)"},
      {establishment_type_id: posto.id, code: "104", abbreviation: "PAM", name: "Posto da Alfândega de Massabi"},
      {establishment_type_id: posto.id, code: "105", abbreviation: "PAL", name: "Posto da Alfândega de Lândana"},
      {establishment_type_id: posto.id, code: "106", abbreviation: "PAO", name: "Posto da Alfândega de Malongo"},
      {establishment_type_id: posto.id, code: "107", abbreviation: "PCA", name: "Posto da Alfândega do Aeroporto (Cabinda)"},
      {establishment_type_id: posto.id, code: "108", abbreviation: "PAY", name: "Posto da Alfândega do Yema"},
      {establishment_type_id: posto.id, code: "109", abbreviation: "PSD", name: "Posto do SIAC de Cabinda"},
      {establishment_type_id: posto.id, code: "111", abbreviation: "PCC", name: "Posto do CLESE de Cabinda"},
      {establishment_type_id: posto.id, code: "202", abbreviation: "PFU", name: "Posto da Repartição Fiscal do Uíge"},
      {establishment_type_id: posto.id, code: "203", abbreviation: "PSU", name: "Posto do Siac do Uíge"},
      {establishment_type_id: posto.id, code: "205", abbreviation: "PCU", name: "Posto do CLESE do Uíge"},
      {establishment_type_id: posto.id, code: "206", abbreviation: "PIU", name: "Posto do ISCED do Uíge"},
      {establishment_type_id: posto.id, code: "207", abbreviation: "PPJ", name: "Posto do Palácio da Justiça do Uíge"},
      {establishment_type_id: posto.id, code: "208", abbreviation: "PMF", name: "Posto do MINFIN do Uíge"},
      {establishment_type_id: posto.id, code: "302", abbreviation: "PJE-III (Soyo)", name: "Posto das Jembas III (Soyo) - FECHADO"},
      {establishment_type_id: posto.id, code: "404", abbreviation: "PCN", name: "Posto do CLESE do Kwanza Norte"},
      {establishment_type_id: posto.id, code: "405", abbreviation: "PLU", name: "Posto do Laúca"},
      {establishment_type_id: posto.id, code: "603", abbreviation: "PPA", name: "Posto da Alfândega do Porto Amboim"},
      {establishment_type_id: posto.id, code: "605", abbreviation: "PCS", name: "Posto do CLESE do Sumbe"},
      {establishment_type_id: posto.id, code: "703", abbreviation: "PFA", name: "Posto da Repartição Fiscal do Ambriz"},
      {establishment_type_id: posto.id, code: "704", abbreviation: "PSX", name: "Posto do SIAC de Caxito"},
      {establishment_type_id: posto.id, code: "802", abbreviation: "PCO", name: "Posto do CLESE do Dundo"},
      {establishment_type_id: posto.id, code: "902", abbreviation: "PMS", name: "Posto do Mercado Municipal do Saurimo"},
      {establishment_type_id: posto.id, code: "903", abbreviation: "PSS", name: "Posto SIAC do Saurimo"},
      {establishment_type_id: posto.id, code: "1105", abbreviation: "PML", name: "Posto da Maxi Lobito"},
      {establishment_type_id: posto.id, code: "1108", abbreviation: "PSB", name: "Posto SIAC Benguela"},
      {establishment_type_id: posto.id, code: "1111", abbreviation: "PCB", name: "Posto do CLESE de Benguela"},
      {establishment_type_id: posto.id, code: "1113", abbreviation: "PAA", name: "Posto do Aeroporto da Catumbela"},
      {establishment_type_id: posto.id, code: "1150", abbreviation: "PLA", name: "Posto da Alfândega do Lobito"},
      {establishment_type_id: posto.id, code: "1203", abbreviation: "PQI", name: "Posto da Quissala"},
      {establishment_type_id: posto.id, code: "1204", abbreviation: "PSH", name: "Posto SIAC do Huambo"},
      {establishment_type_id: posto.id, code: "1206", abbreviation: "PCL", name: "Posto do CLESE do Huambo"},
      {establishment_type_id: posto.id, code: "1302", abbreviation: "PKU", name: "Posto do Kunge"},
      {establishment_type_id: posto.id, code: "1303", abbreviation: "PCH", name: "Posto do Chinguar"},
      {establishment_type_id: posto.id, code: "1402", abbreviation: "PCM", name: "Posto do CLESE do Moxico"},
      {establishment_type_id: posto.id, code: "1502", abbreviation: "PJE-VI (Lubango)", name: "Posto das Jembas VI (Lubango) - FECHADO"},
      {establishment_type_id: posto.id, code: "1506", abbreviation: "PCI", name: "Posto CLESE da Huila"},
      {establishment_type_id: posto.id, code: "1602", abbreviation: "PMN", name: "Posto do Mercado Municipal do Namibe"},
      {establishment_type_id: posto.id, code: "1701", abbreviation: "PUI", name: "Posto da Alfândega de Catuiti"},
      {establishment_type_id: posto.id, code: "1803", abbreviation: "PSO", name: "Posto do SIAC de Ondjiva"},
      {establishment_type_id: posto.id, code: "1904", abbreviation: "PSM", name: "Posto do Siac de Malange"},
      {establishment_type_id: posto.id, code: "1905", abbreviation: "PMJ", name: "Posto do Aeroporto de Malanje"},
      {establishment_type_id: posto.id, code: "1906", abbreviation: "PMG", name: "Posto do Mercado Municipal de Malange"},
      {establishment_type_id: posto.id, code: "1907", abbreviation: "PCG", name: "Posto do CLESE de Malange"},
      {establishment_type_id: posto.id, code: "3002", abbreviation: "PAS", name: "Posto da Alfândega do Soyo"},
      {establishment_type_id: posto.id, code: "5001", abbreviation: "PJE-I (Rainha Ginga)", name: "Posto das Jembas I (Rainha Ginga) - FECHADO"},
      {establishment_type_id: posto.id, code: "5002", abbreviation: "PMA", name: "Posto da Martal - FECHADO"},
      {establishment_type_id: posto.id, code: "5004", abbreviation: "PJE-II (Cassenda)", name: "Posto das Jembas II (Cassenda) - FECHADO"},
      {establishment_type_id: posto.id, code: "5005", abbreviation: "PJE-IV (Viana)", name: "Posto das Jembas IV (Viana)"},
      {establishment_type_id: posto.id, code: "5007", abbreviation: "PJE-V (Atlântico)", name: "Posto das Jembas V (Atlântico) - FECHADO"},
      {establishment_type_id: posto.id, code: "5012", abbreviation: "PMX", name: "Posto da Maxi ( Luanda) - FECHADO"},
      {establishment_type_id: posto.id, code: "5013", abbreviation: "PCD", name: "Posto do Cassenda - FECHADO"},
      {establishment_type_id: posto.id, code: "5014", abbreviation: "PJE-VII", name: "Posto das Jembas VII (Shoprite Palanca)  - FECHADO"},
      {establishment_type_id: posto.id, code: "5016", abbreviation: "PPS", name: "Posto Porto Seco"},
      {establishment_type_id: posto.id, code: "5017", abbreviation: "PHL", name: "Posto da DHL"},
      {establishment_type_id: posto.id, code: "5018", abbreviation: "PMM", name: "Posto do Miramar"},
      {establishment_type_id: posto.id, code: "5019", abbreviation: "PSZ", name: "Posto SIAC do Zango"},
      {establishment_type_id: posto.id, code: "5020", abbreviation: "PSA", name: "Posto SIAC do Cazenga"},
      {establishment_type_id: posto.id, code: "5021", abbreviation: "PMK", name: "Posto  da Martal do Kifica (Benfica) - FECHADO"},
      {establishment_type_id: posto.id, code: "5022", abbreviation: "PCQ", name: "Posto do Cassequel - FECHADO"},
      {establishment_type_id: posto.id, code: "5023", abbreviation: "PLP", name: "Posto da Maternidade Lucrécia Paim "},
      {establishment_type_id: posto.id, code: "5024", abbreviation: "PZE  ", name: "Posto da Zona Económica Especial"},
      {establishment_type_id: posto.id, code: "5025", abbreviation: "PEN", name: "Posto da Enana"},
      {establishment_type_id: posto.id, code: "5026", abbreviation: "PST", name: "Posto do SIAC do Talatona"},
      {establishment_type_id: posto.id, code: "5027", abbreviation: "PCP", name: "Posto Cais do Porto de Luanda"},
      {establishment_type_id: posto.id, code: "5028", abbreviation: "PSC", name: "Posto do SIAC de Cacuaco"},
      {establishment_type_id: posto.id, code: "5029", abbreviation: "PCK", name: "Posto do Clese do Kilamba"},
      {establishment_type_id: posto.id, code: "5030", abbreviation: "PAK", name: "Posto da Aldeia de Kaxicane"},
      {establishment_type_id: posto.id, code: "5031", abbreviation: "PCF", name: "Posto do CLESE do Golf"}
    ]

    caixas_avancados = [
      {establishment_type_id: caixa_avancado.id, code: "5006", abbreviation: "IPL", name: "Terminal da Unicarga (Unicarga)"},
      {establishment_type_id: caixa_avancado.id, code: "5003", abbreviation: "IAL", name: "Terminal  Alf. do Aeroporto (Luanda)"},
      {establishment_type_id: caixa_avancado.id, code: "5003", abbreviation: "5003", name: "Terminal SAL (Luanda)"},
      {establishment_type_id: caixa_avancado.id, code: "5003", abbreviation: "5003", name: "Caixa Avançado - TECA 2"},
      {establishment_type_id: caixa_avancado.id, code: "503", abbreviation: "ICA", name: "Caixa da Fermat - Palanca"},
      {establishment_type_id: caixa_avancado.id, code: "	", abbreviation: "PCD", name: "Caixa Aeroporto de Luanda (Placa)"},
      {establishment_type_id: caixa_avancado.id, code: "505", abbreviation: "IBP", name: "Caixa Avançado da Loja dos Registos ( B. Popular)"},
      {establishment_type_id: caixa_avancado.id, code: "506", abbreviation: "ISP", name: "Caixa do 4ª Cartório (São Paulo)"},
      {establishment_type_id: caixa_avancado.id, code: "506", abbreviation: "ISP", name: "Caixa Avançado da Embaixada do Brasil"},
      {establishment_type_id: caixa_avancado.id, code: "507", abbreviation: "IAC", name: "Caixa Avançado da Chevron"},
      {establishment_type_id: caixa_avancado.id, code: "512", abbreviation: "ICC", name: "Caixa Avançado da Loja dos Registos (Cacuaco)"},
      {establishment_type_id: caixa_avancado.id, code: "514", abbreviation: "IVI", name: "Caixa Avançado da Loja dos Registos (Viana)"},
      {establishment_type_id: caixa_avancado.id, code: "519", abbreviation: "IUA", name: "Caixa Avançado da 5ª Conservatória ( Palanca)"},
      {establishment_type_id: caixa_avancado.id, code: "1802", abbreviation: "PSC", name: "Caixa da Alfândega da Santa Clara"},
      {establishment_type_id: caixa_avancado.id, code: "514", abbreviation: "IVI", name: "Caixa Avançado da Loja dos Registos (Viana)"},
      {establishment_type_id: caixa_avancado.id, code: "522", abbreviation: "ICE", name: "Caixa Avançado da Loja dos Registos (Camama)"},
      {establishment_type_id: caixa_avancado.id, code: "1802", abbreviation: "PSC", name: "Caixa da Alfândega da Santa Clara"}
    ]


    Establishment.create(agencias)
    Establishment.create(dependencias)
    Establishment.create(centros)
    Establishment.create(postos)
    Establishment.create(caixas_avancados)

    Plugin.generate_side_menu true
  end
end
