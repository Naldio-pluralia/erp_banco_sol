class Add2016Assessments < ActiveRecord::Migration[5.1]
  def change
    # assessments = ["10049,3.1",
    #   "10065,3.6",
    #   "10081,3.7",
    #   "10103,3.4",
    #   "10111,3.8",
    #   "10154,4.2",
    #   "10227,3.3",
    #   "1023,3.6",
    #   "10251,4.1",
    #   "10278,4.1",
    #   "10294,0",
    #   "1031,4.7",
    #   "10316,3.4",
    #   "10324,3.3",
    #   "10340,3.5",
    #   "10359,4.5",
    #   "10367,3.8",
    #   "10375,4.2",
    #   "10383,4.1",
    #   "10413,3.9",
    #   "10456,3.9",
    #   "10464,4.5",
    #   "10480,4.4",
    #   "10499,4",
    #   "10510,4",
    #   "10529,4",
    #   "10537,3.8",
    #   "10545,3.5",
    #   "10618,3.8",
    #   "10626,3.1",
    #   "10634,4.2",
    #   "10642,4.1",
    #   "10650,3.6",
    #   "10669,3.9",
    #   "10685,3.9",
    #   "10693,3.9",
    #   "10731,4.1",
    #   "10758,4.9",
    #   "10766,4.4",
    #   "10774,0",
    #   "10790,4.1",
    #   "108,0",
    #   "10804,3.9",
    #   "10812,3.7",
    #   "10820,3.9",
    #   "10839,3.5",
    #   "10847,4.1",
    #   "10855,3.6",
    #   "10863,2.8",
    #   "10901,4.3",
    #   "10944,3.9",
    #   "10960,4.2",
    #   "11029,0",
    #   "11037,3.9",
    #   "11045,3.9",
    #   "11053,4",
    #   "11061,3.5",
    #   "11096,3.9",
    #   "11118,3.6",
    #   "1112,0",
    #   "11169,3.9",
    #   "11177,0",
    #   "11193,3.6",
    #   "11207,4.1",
    #   "11223,4.1",
    #   "11274,3.9",
    #   "11304,0",
    #   "11398,3.6",
    #   "11452,4.2",
    #   "11460,4.6",
    #   "11487,3.6",
    #   "11495,3.7",
    #   "11509,3.8",
    #   "11517,3.5",
    #   "11525,3.6",
    #   "11533,3.1",
    #   "1155,4.2",
    #   "11568,3.9",
    #   "11576,4.8",
    #   "11630,3.5",
    #   "11649,3.9",
    #   "11657,3.8",
    #   "11665,4",
    #   "11673,0",
    #   "11681,3.4",
    #   "1171,4.1",
    #   "11738,3.8",
    #   "11746,4",
    #   "11770,4.6",
    #   "11789,3.6",
    #   "11800,4",
    #   "11851,3.9",
    #   "11924,3.6",
    #   "11932,4.1",
    #   "11940,2.9",
    #   "11967,4.1",
    #   "11975,4.1",
    #   "1198,3.8",
    #   "12009,3.1",
    #   "1201,3.6",
    #   "12017,3.9",
    #   "12025,3.7",
    #   "12033,3.6",
    #   "12041,3.8",
    #   "12076,3.6",
    #   "12092,4.4",
    #   "12106,3.9",
    #   "12114,3.2",
    #   "12122,3.9",
    #   "12149,3.9",
    #   "12157,3.6",
    #   "12181,4.1",
    #   "12211,3.8",
    #   "12238,4",
    #   "12246,4",
    #   "12254,4",
    #   "12297,4.1",
    #   "12300,4",
    #   "12327,4",
    #   "12351,3.8",
    #   "1236,4.1",
    #   "12378,3.9",
    #   "12394,3.7",
    #   "12408,3.9",
    #   "12416,4.2",
    #   "12424,0",
    #   "12432,4.1",
    #   "12459,3.9",
    #   "12483,3.7",
    #   "12491,3.8",
    #   "12548,3.9",
    #   "12572,4.1",
    #   "12580,3.9",
    #   "12599,4.3",
    #   "1260,3.8",
    #   "12610,4.2",
    #   "12637,3.7",
    #   "12645,4",
    #   "12653,3.7",
    #   "12688,4",
    #   "12696,3.9",
    #   "12718,4",
    #   "12726,3.8",
    #   "12734,3.9",
    #   "12742,4",
    #   "12777,4",
    #   "12785,4",
    #   "1279,3.9",
    #   "12815,4.1",
    #   "12823,3.9",
    #   "12858,3.8",
    #   "12866,3.9",
    #   "12882,3.7",
    #   "12890,3.9",
    #   "12912,4",
    #   "12920,3.6",
    #   "12939,4",
    #   "12947,3.9",
    #   "1295,4.2",
    #   "12963,4",
    #   "12971,3.9",
    #   "12998,3.8",
    #   "13013,3.5",
    #   "13048,4.1",
    #   "13056,3.9",
    #   "13064,3.5",
    #   "13072,4.1",
    #   "1309,3.2",
    #   "13099,3.9",
    #   "13129,3.6",
    #   "13145,3.1",
    #   "13188,3.9",
    #   "13196,3.9",
    #   "132,4",
    #   "13234,3.9",
    #   "13250,3.9",
    #   "13277,0",
    #   "13285,0",
    #   "13307,3.8",
    #   "13315,3.6",
    #   "13382,4.1",
    #   "13412,3.1",
    #   "13420,4",
    #   "13439,3.1",
    #   "13447,4.1",
    #   "13498,3.5",
    #   "13501,4.1",
    #   "13528,3.4",
    #   "13544,3.6",
    #   "13560,3.8",
    #   "13595,3.9",
    #   "13609,4",
    #   "13633,3.5",
    #   "13641,3.8",
    #   "13668,3.9",
    #   "13684,4.2",
    #   "13692,3.6",
    #   "13714,3.9",
    #   "13722,4",
    #   "13730,4.2",
    #   "13757,3.9",
    #   "1376,0",
    #   "13765,3.4",
    #   "13781,3.6",
    #   "13811,3.6",
    #   "13854,3.8",
    #   "13889,3.4",
    #   "13919,3.6",
    #   "1392,0",
    #   "13927,3.4",
    #   "13935,3.9",
    #   "13943,4",
    #   "13951,4.4",
    #   "13994,4.7",
    #   "14028,4.2",
    #   "14036,3.8",
    #   "14044,4.2",
    #   "14052,4",
    #   "1406,3.9",
    #   "14109,4",
    #   "14117,3.7",
    #   "14125,3.5",
    #   "14141,3.9",
    #   "14176,3.8",
    #   "14184,3.6",
    #   "14192,4.2",
    #   "14214,3.6",
    #   "1422,3.7",
    #   "14222,4",
    #   "14230,4",
    #   "14257,4",
    #   "14265,3.9",
    #   "14273,4",
    #   "14281,3.4",
    #   "1430,4",
    #   "14311,3.8",
    #   "14338,3.6",
    #   "14346,4.5",
    #   "14362,4",
    #   "14397,3.9",
    #   "14419,3.9",
    #   "14435,4.5",
    #   "14443,3.8",
    #   "14451,4",
    #   "14478,0",
    #   "14494,3.9",
    #   "14508,4",
    #   "14524,3.3",
    #   "14532,3.8",
    #   "14540,3.5",
    #   "14559,4.2",
    #   "14575,4",
    #   "14591,3.9",
    #   "14613,4.1",
    #   "14648,2.6",
    #   "14729,4.4",
    #   "14737,4",
    #   "14753,3.9",
    #   "14788,3.8",
    #   "14796,3.9",
    #   "14818,3.6",
    #   "14826,3.6",
    #   "14850,3.9",
    #   "14877,3.2",
    #   "14885,3.7",
    #   "14893,3.9",
    #   "14923,4.1",
    #   "14931,4.1",
    #   "14958,3.9",
    #   "14966,3.6",
    #   "14974,3.7",
    #   "14990,3.9",
    #   "15016,4.1",
    #   "15024,3.8",
    #   "1503,4.4",
    #   "15059,4.1",
    #   "15067,4.5",
    #   "15091,3.6",
    #   "15121,3.8",
    #   "15148,3.4",
    #   "15156,3.2",
    #   "15164,2.5",
    #   "15172,4",
    #   "15180,4",
    #   "15202,3.9",
    #   "15229,4",
    #   "15237,3.9",
    #   "15245,4",
    #   "15261,3.6",
    #   "15288,3.7",
    #   "15296,4.2",
    #   "15334,3.9",
    #   "15350,3.8",
    #   "15377,3.6",
    #   "15393,4",
    #   "15407,4.2",
    #   "15415,3.4",
    #   "15423,3.8",
    #   "15431,3.4",
    #   "15458,3.9",
    #   "15466,3.3",
    #   "15474,3.6",
    #   "15482,3.9",
    #   "15504,0",
    #   "15539,3.9",
    #   "1554,4.1",
    #   "15563,4.1",
    #   "15598,3.9",
    #   "15601,3.5",
    #   "1562,3.8",
    #   "15628,3.8",
    #   "15636,3.9",
    #   "15644,4.1",
    #   "15652,0",
    #   "15660,3.6",
    #   "15687,3.8",
    #   "15695,3.5",
    #   "15717,3.6",
    #   "15768,3.1",
    #   "15776,3.6",
    #   "15784,3.6",
    #   "15806,3.2",
    #   "15814,4",
    #   "15822,3.7",
    #   "15830,3.8",
    #   "15857,3.9",
    #   "15881,3.9",
    #   "159,3.5",
    #   "15903,3.8",
    #   "15938,4.3",
    #   "15946,3.6",
    #   "15962,3.9",
    #   "15970,3.8",
    #   "15997,3",
    #   "1600,3.6",
    #   "16012,3.4",
    #   "16039,3.1",
    #   "16055,4.1",
    #   "16098,3.6",
    #   "16128,3.5",
    #   "16136,4",
    #   "16179,4",
    #   "16187,4",
    #   "16195,3.9",
    #   "16209,3.6",
    #   "16217,0",
    #   "16225,3.9",
    #   "16241,4.1",
    #   "16268,3.5",
    #   "16276,4.6",
    #   "16284,4",
    #   "16292,4",
    #   "16306,4",
    #   "16314,4.3",
    #   "16322,4",
    #   "16349,3.5",
    #   "16365,3.6",
    #   "16373,3.9",
    #   "16381,4.1",
    #   "1643,3.8",
    #   "16446,3.8",
    #   "16454,3.6",
    #   "16497,4.1",
    #   "1651,3.8",
    #   "16535,3.5",
    #   "16551,3.8",
    #   "16578,4.1",
    #   "16586,3.9",
    #   "16594,3.8",
    #   "16616,3.4",
    #   "16624,4",
    #   "16632,4.1",
    #   "16675,3.9",
    #   "16683,4.6",
    #   "16705,4.1",
    #   "16721,3.9",
    #   "16748,4.1",
    #   "16756,4.4",
    #   "16764,3.4",
    #   "16780,3.6",
    #   "16799,3.3",
    #   "16802,3.7",
    #   "16810,4.1",
    #   "16829,4",
    #   "1686,4",
    #   "16861,3.3",
    #   "16918,0",
    #   "16926,3.8",
    #   "16942,3.3",
    #   "16969,3.9",
    #   "16993,4",
    #   "17027,4",
    #   "17035,3.9",
    #   "17043,4.1",
    #   "17051,4",
    #   "17078,4.1",
    #   "17086,4",
    #   "17094,3.9",
    #   "17108,3.1",
    #   "17116,3.9",
    #   "17124,3.2",
    #   "17132,4",
    #   "17140,3.8",
    #   "17159,4",
    #   "17183,3.8",
    #   "17191,4.1",
    #   "17205,2.8",
    #   "17213,3.4",
    #   "17256,3.8",
    #   "17264,4",
    #   "17272,3.4",
    #   "17299,3.7",
    #   "17302,4",
    #   "17310,3.7",
    #   "1732,3.8",
    #   "17329,3.6",
    #   "17345,3.7",
    #   "17388,3.9",
    #   "17418,3.8",
    #   "17434,4.2",
    #   "17442,4.7",
    #   "17469,4.1",
    #   "17477,3.9",
    #   "17485,3.8",
    #   "17493,3.4",
    #   "17507,3.4",
    #   "17531,3.9",
    #   "17558,3.9",
    #   "17566,3.9",
    #   "17574,4.4",
    #   "17604,4",
    #   "17612,3.9",
    #   "17639,3.5",
    #   "17647,3.4",
    #   "17655,3.8",
    #   "17663,3.6",
    #   "1767,3.8",
    #   "17698,3.1",
    #   "17728,4",
    #   "17760,4",
    #   "17779,4.1",
    #   "17809,4.1",
    #   "17817,4",
    #   "17825,3.4",
    #   "1783,4.1",
    #   "17841,3.9",
    #   "17868,3.9",
    #   "17876,3.9",
    #   "17884,3.9",
    #   "17892,3.9",
    #   "1791,3.9",
    #   "17914,4",
    #   "17922,3.8",
    #   "17930,3.4",
    #   "17949,3.6",
    #   "17957,3.9",
    #   "17965,0",
    #   "17973,3.1",
    #   "17981,3.8",
    #   "18007,3.4",
    #   "18023,3.7",
    #   "1805,0",
    #   "18058,4",
    #   "18074,4.1",
    #   "18082,3.9",
    #   "18090,3.7",
    #   "18104,4",
    #   "18120,3.6",
    #   "1813,3.9",
    #   "18139,4.1",
    #   "18147,3.4",
    #   "18171,3.7",
    #   "18244,3.7",
    #   "18252,4",
    #   "18260,3.9",
    #   "18287,4",
    #   "18295,3.6",
    #   "18368,4.1",
    #   "18376,3.6",
    #   "18384,3.6",
    #   "18406,3.7",
    #   "18414,0",
    #   "18422,4.6",
    #   "18430,3.4",
    #   "18449,3.4",
    #   "18457,4.4",
    #   "18465,4.5",
    #   "1848,3",
    #   "18503,4.4",
    #   "18511,3.6",
    #   "18538,3.9",
    #   "18546,4.1",
    #   "18562,3.7",
    #   "18570,3.6",
    #   "18589,3.8",
    #   "18597,4.1",
    #   "18619,3.6",
    #   "18627,3.9",
    #   "18635,2.7",
    #   "18651,3.8",
    #   "18678,3.6",
    #   "18686,3.3",
    #   "18694,4.1",
    #   "18708,4.1",
    #   "1872,3.8",
    #   "18724,3.6",
    #   "18740,3.9",
    #   "18759,3.8",
    #   "18783,3.7",
    #   "1880,3.8",
    #   "18805,3.9",
    #   "18821,3.4",
    #   "18848,3.9",
    #   "18856,4.4",
    #   "18864,4.2",
    #   "18872,0",
    #   "18880,4.1",
    #   "18899,3.6",
    #   "18902,3.4",
    #   "18910,3.6",
    #   "18937,4.1",
    #   "18945,4.4",
    #   "18953,3.7",
    #   "18961,3.7",
    #   "1899,4.1",
    #   "18996,3.9",
    #   "19003,4.2",
    #   "19011,3.9",
    #   "1902,4",
    #   "19062,4.1",
    #   "19070,3.9",
    #   "19089,4.1",
    #   "19097,4.1",
    #   "1910,3.7",
    #   "19100,3.9",
    #   "19127,3.8",
    #   "19135,3.6",
    #   "19143,3.6",
    #   "19151,3.6",
    #   "19178,4",
    #   "19186,3.4",
    #   "19194,4",
    #   "19208,4",
    #   "19216,4.2",
    #   "19224,4.2",
    #   "19232,3.7",
    #   "19240,3.8",
    #   "19259,4.1",
    #   "19267,4.4",
    #   "19275,3.5",
    #   "19283,4.2",
    #   "1929,4.1",
    #   "19291,3.3",
    #   "19313,3.4",
    #   "19321,3.3",
    #   "19364,3.6",
    #   "19372,3.5",
    #   "19410,3.8",
    #   "19429,3.2",
    #   "19445,3.9",
    #   "19453,4",
    #   "19461,4.1",
    #   "19496,4.1",
    #   "19518,4.2",
    #   "19526,4.1",
    #   "1953,4.1",
    #   "19542,4",
    #   "19550,4",
    #   "19569,3.9",
    #   "19585,4.1",
    #   "19593,4",
    #   "19615,3.5",
    #   "19623,3.6",
    #   "19631,3.1",
    #   "19658,3.7",
    #   "19666,4.5",
    #   "19682,4",
    #   "19739,4.1",
    #   "19755,3.2",
    #   "19771,3.6",
    #   "19798,4.1",
    #   "19801,3.7",
    #   "19828,3.9",
    #   "19836,3.9",
    #   "19844,3.7",
    #   "19852,3.8",
    #   "19860,3",
    #   "19879,3.9",
    #   "1988,4.9",
    #   "19887,4",
    #   "19895,3.7",
    #   "19909,3.9",
    #   "19917,4",
    #   "19925,4",
    #   "19933,4.1",
    #   "19968,4",
    #   "19976,4.3",
    #   "19984,4",
    #   "19992,3.7",
    #   "20028,3.8",
    #   "20052,4",
    #   "20079,4",
    #   "20087,3.5",
    #   "20095,3.6",
    #   "2011,4",
    #   "20125,4.1",
    #   "20141,3.7",
    #   "20184,3.6",
    #   "20206,3",
    #   "20214,3.5",
    #   "20230,4.1",
    #   "20249,0",
    #   "20257,3.6",
    #   "20265,3.9",
    #   "20303,4.1",
    #   "20338,0",
    #   "20346,3.7",
    #   "20354,4.7",
    #   "20362,3.4",
    #   "20370,3.9",
    #   "2038,3.9",
    #   "20389,3.6",
    #   "20397,3.3",
    #   "20419,4",
    #   "20435,3.9",
    #   "20478,3.6",
    #   "20486,3.3",
    #   "20508,4",
    #   "20516,3.8",
    #   "20524,4.1",
    #   "20532,4",
    #   "20540,3.9",
    #   "20559,3.2",
    #   "20575,4.1",
    #   "20583,4",
    #   "20591,3.6",
    #   "20605,3.4",
    #   "20613,3.9",
    #   "2062,2.9",
    #   "20621,3.7",
    #   "20648,3.2",
    #   "20664,4.1",
    #   "20672,3.9",
    #   "20680,4.1",
    #   "20699,3.7",
    #   "2070,3.7",
    #   "20702,3.9",
    #   "20710,3.6",
    #   "20737,4",
    #   "20745,4",
    #   "20753,0",
    #   "20761,4.1",
    #   "20788,4.4",
    #   "20796,4.6",
    #   "20818,3.9",
    #   "20826,3.8",
    #   "20834,3.6",
    #   "20842,3.5",
    #   "20850,3.3",
    #   "20869,2.8",
    #   "20885,3.7",
    #   "2089,3.8",
    #   "20893,3.6",
    #   "20931,3.8",
    #   "20982,3.4",
    #   "21016,4.1",
    #   "21024,3.3",
    #   "21032,4.1",
    #   "21067,3.6",
    #   "21075,2.7",
    #   "21091,3.9",
    #   "21105,2.6",
    #   "21113,3.9",
    #   "21121,3.9",
    #   "21148,3",
    #   "21156,3.9",
    #   "21164,4",
    #   "21172,3.8",
    #   "21180,4",
    #   "2119,3.5",
    #   "21210,3.5",
    #   "21229,3.7",
    #   "21237,4.1",
    #   "21245,3.7",
    #   "21253,4",
    #   "21261,3.4",
    #   "21288,3.8",
    #   "21296,4",
    #   "21318,3.3",
    #   "21326,3.5",
    #   "21334,3.1",
    #   "21350,3.6",
    #   "21369,3.6",
    #   "21385,0",
    #   "21393,3.9",
    #   "21407,4.1",
    #   "21415,3.6",
    #   "21423,3.7",
    #   "21431,4",
    #   "21466,3.7",
    #   "21482,3.4",
    #   "21490,3.9",
    #   "21504,4",
    #   "21512,3.5",
    #   "21520,3",
    #   "21539,3.4",
    #   "21555,3.9",
    #   "21571,3.6",
    #   "21598,4.5",
    #   "21601,3.4",
    #   "21628,3.7",
    #   "21636,2.9",
    #   "21644,3.4",
    #   "21652,3.9",
    #   "21660,3.7",
    #   "21679,3.7",
    #   "21687,2.7",
    #   "21695,3.7",
    #   "21709,3.9",
    #   "21717,3.4",
    #   "21725,3.5",
    #   "21733,3.9",
    #   "21741,3.8",
    #   "21768,4",
    #   "21776,4",
    #   "21784,3.7",
    #   "21792,4.5",
    #   "21822,3.6",
    #   "21849,4.1",
    #   "21903,3.9",
    #   "21911,0",
    #   "21938,4.4",
    #   "2194,4.7",
    #   "21946,3.8",
    #   "21954,3.6",
    #   "21962,3.9",
    #   "21970,3.6",
    #   "21989,2.6",
    #   "21997,3.5",
    #   "22004,3.6",
    #   "22012,3.6",
    #   "22020,3.1",
    #   "22055,4",
    #   "22063,3.9",
    #   "22071,0",
    #   "22098,3.9",
    #   "22101,3.9",
    #   "22128,3.9",
    #   "22136,3.7",
    #   "22144,4",
    #   "22160,0",
    #   "22179,3.9",
    #   "22187,3.7",
    #   "22209,3.5",
    #   "22217,3.5",
    #   "22225,3.3",
    #   "22233,0",
    #   "2224,3.6",
    #   "22241,3.4",
    #   "22276,3.4",
    #   "22284,3.9",
    #   "22292,4",
    #   "22306,4",
    #   "22330,3.1",
    #   "22349,4.1",
    #   "22357,3.5",
    #   "22373,4.3",
    #   "2240,3.8",
    #   "22403,4",
    #   "22438,3.9",
    #   "22446,3.8",
    #   "22454,4.1",
    #   "22462,3.9",
    #   "22470,4.1",
    #   "22489,4.1",
    #   "22497,3.6",
    #   "22500,3.8",
    #   "22519,3.4",
    #   "22527,4.1",
    #   "22535,3.6",
    #   "22543,4.2",
    #   "22551,4.4",
    #   "22578,3.7",
    #   "22586,4",
    #   "22594,3.3",
    #   "22608,0",
    #   "22624,3.7",
    #   "22632,4.4",
    #   "22640,3.4",
    #   "22659,4.5",
    #   "22667,3.6",
    #   "22675,3.8",
    #   "22683,3.9",
    #   "22705,3.9",
    #   "22713,3.4",
    #   "22721,3.6",
    #   "22748,3.6",
    #   "22756,3.4",
    #   "22764,3.5",
    #   "22772,3.3",
    #   "22799,3.5",
    #   "22802,3.8",
    #   "22810,3.7",
    #   "22829,3.1",
    #   "22837,3.7",
    #   "22845,4",
    #   "22853,3.6",
    #   "22861,4",
    #   "22888,3.8",
    #   "22896,4.5",
    #   "22926,3.6",
    #   "22934,4",
    #   "22950,0",
    #   "22969,0",
    #   "22977,3.6",
    #   "22985,4.4",
    #   "22993,3.9",
    #   "23000,4",
    #   "23019,4",
    #   "23027,3.6",
    #   "23035,3",
    #   "23043,4.1",
    #   "2305,3.9",
    #   "23051,3.1",
    #   "23078,0",
    #   "23086,4.6",
    #   "23094,3.9",
    #   "23108,0",
    #   "23116,4",
    #   "2313,4.1",
    #   "23140,4",
    #   "23159,4",
    #   "23167,3.9",
    #   "23175,4.6",
    #   "23183,3.6",
    #   "23191,3.4",
    #   "23213,4.4",
    #   "23221,3.9",
    #   "23248,4.1",
    #   "23256,3.9",
    #   "23264,3.8",
    #   "23272,4",
    #   "23280,3.3",
    #   "23299,3.8",
    #   "23302,3.6",
    #   "23310,3.9",
    #   "23329,3.9",
    #   "23337,3.7",
    #   "23345,3.8",
    #   "23353,3.9",
    #   "23361,0",
    #   "23396,3.5",
    #   "23434,3.8",
    #   "23442,3.8",
    #   "23469,3.2",
    #   "23477,3.7",
    #   "2348,3.6",
    #   "23485,3.6",
    #   "23515,3.6",
    #   "23523,3.7",
    #   "23558,3.8",
    #   "23566,3.9",
    #   "23582,3.7",
    #   "23590,4",
    #   "23612,3.6",
    #   "23620,3.6",
    #   "23639,3.2",
    #   "23647,3.6",
    #   "23655,3.2",
    #   "23663,4",
    #   "23671,3.9",
    #   "23698,3.6",
    #   "23701,3.9",
    #   "23728,3.7",
    #   "23736,4.3",
    #   "23744,2.7",
    #   "23752,3.9",
    #   "23779,3.2",
    #   "23787,3.5",
    #   "23795,4",
    #   "23809,4",
    #   "23817,3.3",
    #   "23825,4.1",
    #   "23833,3.6",
    #   "23841,3.9",
    #   "23868,4.3",
    #   "23876,4.3",
    #   "23884,3.4",
    #   "23892,3.6",
    #   "23906,3.4",
    #   "23914,0",
    #   "23922,3.2",
    #   "23930,3.8",
    #   "23949,3.4",
    #   "23965,3.6",
    #   "23973,3.9",
    #   "24007,3.9",
    #   "24066,3.6",
    #   "24082,3.9",
    #   "24090,4.1",
    #   "2410,3.7",
    #   "24104,4",
    #   "24112,3.6",
    #   "24139,3.7",
    #   "24155,3.9",
    #   "24163,3.9",
    #   "24171,3.6",
    #   "24198,3",
    #   "24201,3.9",
    #   "24228,3.9",
    #   "24236,3.9",
    #   "24244,3.8",
    #   "24252,4.1",
    #   "24260,4.1",
    #   "24279,3.3",
    #   "24287,0",
    #   "2429,4",
    #   "24295,3.5",
    #   "24317,3.8",
    #   "24325,3.9",
    #   "24333,3",
    #   "24341,3.5",
    #   "24368,3.9",
    #   "24376,0",
    #   "24384,3.1",
    #   "24392,4.1",
    #   "24414,3.8",
    #   "24422,4.4",
    #   "24430,4.4",
    #   "24457,3.9",
    #   "24465,4",
    #   "24473,3.6",
    #   "24481,3.4",
    #   "24511,0",
    #   "2453,4",
    #   "24538,3.9",
    #   "24546,3.4",
    #   "24562,0",
    #   "24589,3.5",
    #   "24600,3.8",
    #   "24619,3.1",
    #   "24627,3.4",
    #   "24635,4.1",
    #   "24643,4.4",
    #   "24651,3.9",
    #   "24678,3.9",
    #   "24686,3.9",
    #   "24694,3.7",
    #   "24708,3.6",
    #   "24716,3.1",
    #   "24724,3.8",
    #   "24732,3.9",
    #   "24740,3.1",
    #   "24759,3.9",
    #   "24767,3.9",
    #   "24775,3.9",
    #   "24783,3.8",
    #   "24791,3.9",
    #   "24805,3.7",
    #   "24813,0",
    #   "24821,3.9",
    #   "24848,4",
    #   "24856,3.7",
    #   "24864,4.1",
    #   "24872,4.1",
    #   "24880,3.9",
    #   "24899,4.1",
    #   "24902,3.9",
    #   "24910,4",
    #   "24929,2.9",
    #   "24937,3.5",
    #   "24945,3.2",
    #   "24953,3.1",
    #   "24961,3.6",
    #   "24988,0",
    #   "24996,3.9",
    #   "25003,3.5",
    #   "25011,3.8",
    #   "25038,4",
    #   "25046,3.2",
    #   "25054,3.1",
    #   "25062,4",
    #   "25089,3.9",
    #   "25097,4.2",
    #   "25100,4.2",
    #   "25119,3.7",
    #   "25127,2.9",
    #   "25135,4",
    #   "25143,4.1",
    #   "25151,4.3",
    #   "25178,3.4",
    #   "2518,4.3",
    #   "25186,3",
    #   "25194,3.3",
    #   "25216,3.9",
    #   "25224,3.9",
    #   "2526,4.7",
    #   "25267,4",
    #   "25275,3.3",
    #   "25291,3.9",
    #   "2534,3.9",
    #   "25372,3.4",
    #   "25380,3.6",
    #   "25402,3.6",
    #   "25410,3.4",
    #   "2542,3.1",
    #   "25429,3.5",
    #   "25437,3.8",
    #   "2550,4.3",
    #   "25518,3.6",
    #   "25526,3.5",
    #   "25747,3.3",
    #   "25763,3.9",
    #   "2577,4.4",
    #   "25771,3.9",
    #   "25798,3.6",
    #   "25828,3.7",
    #   "2585,4.1",
    #   "25879,3.6",
    #   "2593,0",
    #   "25933,4",
    #   "2623,3.7",
    #   "2631,3.8",
    #   "2666,4",
    #   "2682,4.3",
    #   "272,4.4",
    #   "2771,3.3",
    #   "2844,4.4",
    #   "2887,3.9",
    #   "2917,4",
    #   "2925,4.1",
    #   "2968,4.7",
    #   "2976,4",
    #   "299,3.3",
    #   "2992,3.8",
    #   "3026,3.9",
    #   "3034,4",
    #   "3050,3.7",
    #   "3077,4.1",
    #   "3085,4.1",
    #   "3093,4.1",
    #   "310,3.5",
    #   "3115,4.1",
    #   "3123,4.1",
    #   "3166,3.9",
    #   "3182,4.1",
    #   "3328,3.7",
    #   "337,4",
    #   "3395,4",
    #   "3417,4.5",
    #   "3433,4",
    #   "3441,4",
    #   "345,3.8",
    #   "3476,3.6",
    #   "3506,3.7",
    #   "3514,3.9",
    #   "3522,3.6",
    #   "3557,4",
    #   "3573,3",
    #   "3581,3.6",
    #   "361,3.9",
    #   "3611,3.7",
    #   "3638,3.8",
    #   "3670,3.9",
    #   "3697,3.4",
    #   "3700,3.9",
    #   "3719,3.9",
    #   "3735,4",
    #   "3751,3.5",
    #   "3794,3.8",
    #   "3832,0",
    #   "3867,3.5",
    #   "388,3.6",
    #   "3883,3.8",
    #   "3913,4.3",
    #   "3921,3.7",
    #   "396,3.4",
    #   "3964,0",
    #   "3972,3.5",
    #   "4014,3.4",
    #   "4049,3.9",
    #   "4057,4.1",
    #   "4073,3.6",
    #   "4081,3.4",
    #   "4103,3.3",
    #   "4111,0",
    #   "4138,2.9",
    #   "4162,3.9",
    #   "4219,4",
    #   "4227,3.7",
    #   "4235,3.6",
    #   "4243,3.6",
    #   "4251,4.6",
    #   "4278,4.3",
    #   "4286,4.8",
    #   "4294,3.9",
    #   "4359,4",
    #   "4383,3.8",
    #   "4405,4.2",
    #   "4421,3.7",
    #   "4456,2.9",
    #   "4499,3.7",
    #   "450,4",
    #   "4502,3.9",
    #   "4510,3.5",
    #   "4545,4.1",
    #   "4596,4",
    #   "4642,3.8",
    #   "4677,4.9",
    #   "4707,3.9",
    #   "4758,4.3",
    #   "4766,3.6",
    #   "4782,4.3",
    #   "4804,3.9",
    #   "4812,3.9",
    #   "4820,4.4",
    #   "485,4.6",
    #   "4855,4.1",
    #   "4901,3.9",
    #   "493,3.4",
    #   "4936,4.3",
    #   "4960,4.2",
    #   "4987,3.6",
    #   "5002,3.7",
    #   "5010,3.6",
    #   "507,4.6",
    #   "5096,2.9",
    #   "5126,4.5",
    #   "5150,3.1",
    #   "5193,4",
    #   "5215,3.4",
    #   "5231,3.8",
    #   "5266,3.7",
    #   "5282,4.4",
    #   "5290,3.6",
    #   "5304,3.6",
    #   "531,3.8",
    #   "5312,3.5",
    #   "5320,3.5",
    #   "5347,3.9",
    #   "5428,4.4",
    #   "5436,3.8",
    #   "5444,3.9",
    #   "5452,4",
    #   "5460,4",
    #   "5487,4.2",
    #   "5495,4.1",
    #   "5509,3.1",
    #   "5517,4",
    #   "5525,4.4",
    #   "5533,4.3",
    #   "5576,0",
    #   "5592,4",
    #   "5622,3.7",
    #   "5630,4.4",
    #   "5649,3.8",
    #   "5665,3.9",
    #   "5673,4.3",
    #   "5681,4.1",
    #   "5703,4",
    #   "5738,4.2",
    #   "574,4",
    #   "5770,3.8",
    #   "5789,3.1", "5835,3.6", "5843,3.7", "5878,3.2", "590,4.7", "5967,4", "5975,4.1", "6017,3.6", "6025,4.7", "6033,4.5", "604,4.7", "6076,3.7", "6084,4", "612,0", "6122,3.6", "6157,4.1", "6165,4", "6181,4", "6203,3.9", "6211,3.9", "6238,4.3", "6246,3.7", "6254,4", "6262,3.5", "6270,4", "6289,4", "6297,3.9", "6327,4.1", "6343,4.1", "6351,4.1", "6386,3", "6408,3.9", "6432,4", "6440,3.5", "6491,4.1", "6572,4.1", "6580,4", "6637,2.6", "6688,3.9", "671,0", "6726,4.3", "6742,3.9", "6769,3.9", "6777,3.5", "6785,4.6", "6793,4.1", "6807,0", "6823,3.7", "6890,4", "6912,3.9", "6920,0", "6947,4", "6963,3.7", "6998,3.9", "7005,4.2", "7048,4.2", "7072,3.9", "7080,3.6", "7099,0", "7102,4.1", "7110,3.8", "7129,4.4", "7137,3.7", "7145,3.8", "7153,3.9", "7161,3.7", "7226,4.1", "7234,4", "7250,4.1", "7269,3.6", "7315,3.9", "736,4.6", "7374,4.4", "7382,4.2", "7390,4.1", "7412,3.9", "7420,3.8", "7439,4.2", "744,3.6", "7463,3.5", "7471,3.9", "752,4", "7579,4.7", "7587,3.2", "760,3.9", "7609,3.4", "7617,3.3", "7625,4.9", "7633,3.6", "7641,4.4", "7676,4", "7706,3.6", "7714,4.1", "7722,3.8", "7730,0", "7749,4.4", "7765,4.6", "7838,3", "7846,3.3", "7862,3.1", "7889,4", "7927,3.8", "7935,4.2", "7943,3.8", "7951,3.6", "7986,3.5", "7994,3.9", "8044,3.9", "8117,4.2", "8125,3.8", "8133,4.1", "8168,3.9", "8176,3.4", "825,4.4", "8265,3.6", "8273,0", "8281,3.9", "8338,3.7", "8346,4.5", "8354,3.9", "8397,3.3", "8400,4", "841,4.1", "8419,3.8", "8435,3.8", "8443,4.2", "8451,3.5", "8478,3.9", "8486,3.9", "8508,3.5", "8516,3.4", "8524,0", "8532,4", "8567,4.5", "8583,4.1", "8591,3.6", "8605,4.2", "8613,3.1", "8648,4.4", "8656,4.1", "8672,3.2", "868,4.1", "8737,0", "8753,3.9", "8788,3.6", "8826,3.9", "8834,3.8", "884,3.8", "8842,3.9", "8850,4.1", "8877,3.9", "8893,4", "8915,4.1", "8966,3.7", "9008,4.2", "9016,4.3", "9032,3.9", "906,4", "9091,3.8", "9121,3.9", "9172,3.8", "9180,4.1", "9202,4", "9210,4.3", "9229,3.9", "9237,3.9", "9296,3.6", "930,0", "9326,4", "9334,4.2", "9342,3.7", "9369,3.8", "9393,4", "9407,3.8", "9423,0", "9466,3.4", "9512,3.8", "9547,3.6", "9555,4.5", "9563,3.9", "957,3.9", "9571,3.9", "9601,3.6", "9636,3.6", "9644,3.4", "9660,4.6", "9679,3.9", "9687,2.9", "9733,3.5", "9741,3.6", "9776,4.4", "9784,4.1", "9792,4", "9806,4.4", "9814,3.9", "9830,4.4", "9857,3.8", "9873,4", "9881,3.7", "9903,4.8", "9938,4", "9946,3.7", "9962,3.8", "9970,0"]
    # employees = Employee.all.map{|e| [e.number.to_s, e.id]}.to_h
    # p employees
    # p assessments = assessments.map{|a| [employees[a.split(',')[0]], a.split(',')[1]] }
    # p assessment = Assessment.find_by(year: 2016) || Assessment.create(year: 2016)
    # p EmployeeAssessment.create(assessments.map{|a| {assessment_id: assessment.id, employee_id: a.first, result: a.second, manual: true}})

  end
end
