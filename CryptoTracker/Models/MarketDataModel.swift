//
//  MarketDataModel.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 04/05/2023.
//
/*
// url : https://api.coingecko.com/api/v3/global

 response:
 {
   "data": {
     "active_cryptocurrencies": 10704,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 727,
     "total_market_cap": {
       "btc": 42835418.43837165,
       "eth": 654621260.3589679,
       "ltc": 14126654189.7986,
       "bch": 10490469602.454151,
       "bnb": 3821458911.494081,
       "eos": 1218675756053.1418,
       "xrp": 2701920914944.321,
       "xlm": 13291676053549.191,
       "link": 176137650254.4246,
       "dot": 216621749144.3242,
       "yfi": 154840418.15362418,
       "usd": 1245576763332.6792,
       "aed": 4574131547986.593,
       "ars": 280471377548996,
       "aud": 1868801096866.1843,
       "bdt": 132149719557863.45,
       "bhd": 469561264971.4407,
       "bmd": 1245576763332.6792,
       "brl": 6220285798407.047,
       "cad": 1695525176588.684,
       "chf": 1104943673291.8374,
       "clp": 1000479399662760.9,
       "cny": 8615654471972.145,
       "czk": 26494412971919.94,
       "dkk": 8401995707450.6,
       "eur": 1127552137123.0874,
       "gbp": 991086746932.36,
       "hkd": 9775379856892.113,
       "huf": 421088930265289.25,
       "idr": 18317347472343756,
       "ils": 4532663806381.714,
       "inr": 101900009728710.95,
       "jpy": 167759675980800.88,
       "krw": 1649181358190321,
       "kwd": 381523899339.0892,
       "lkr": 398216635837489.4,
       "mmk": 2615091701694032.5,
       "mxn": 22337537183882.19,
       "myr": 5546553327120.433,
       "ngn": 571173154111141.8,
       "nok": 13326635047792.535,
       "nzd": 1996618447589.0906,
       "php": 69016789404612.36,
       "pkr": 351914763482206.75,
       "pln": 5170213518270.331,
       "rub": 97983799300577.5,
       "sar": 4671250413800.384,
       "sek": 12780090910963.354,
       "sgd": 1654848376228.527,
       "thb": 42128508867628.59,
       "try": 24272896920673.777,
       "twd": 38224880010381.33,
       "uah": 45826714713913.68,
       "vef": 124719601312.50081,
       "vnd": 29205661158242970,
       "zar": 22767814203314.87,
       "xdr": 922728248583.9003,
       "xag": 48737201622.56907,
       "xau": 612362904.1572437,
       "bits": 42835418438371.65,
       "sats": 4283541843837165
     },
     "total_volume": {
       "btc": 3042339.216294478,
       "eth": 46493766.25269904,
       "ltc": 1003330318.7755377,
       "bch": 745074245.3889905,
       "bnb": 271414981.6611062,
       "eos": 86555126102.52765,
       "xrp": 191901007589.96686,
       "xlm": 944026900686.7238,
       "link": 12509985903.510357,
       "dot": 15385325194.669325,
       "yfi": 10997373.052254789,
       "usd": 88465741018.59547,
       "aed": 324872740742.5878,
       "ars": 19920175921547.09,
       "aud": 132729574537.24966,
       "bdt": 9385790751913.307,
       "bhd": 33350080446.412983,
       "bmd": 88465741018.59547,
       "brl": 441789064072.7625,
       "cad": 120422839906.9297,
       "chf": 78477428063.14978,
       "clp": 71057966133048.5,
       "cny": 611917530625.6251,
       "czk": 1881736995592.5962,
       "dkk": 596742648205.7388,
       "eur": 80083169728.37819,
       "gbp": 70390863142.38094,
       "hkd": 694285770444.5135,
       "huf": 29907385355339.133,
       "idr": 1300969771867188.8,
       "ils": 321927539292.5962,
       "inr": 7237337862929.28,
       "jpy": 11914949351633.951,
       "krw": 117131320382052.86,
       "kwd": 27097321871.21882,
       "lkr": 28282905407642.504,
       "mmk": 185734056729631.34,
       "mxn": 1586499393433.8298,
       "myr": 393937944755.8065,
       "ngn": 40566954856458.58,
       "nok": 946509825402.4413,
       "nzd": 141807663483.3546,
       "php": 4901842742367.088,
       "pkr": 24994365055060.1,
       "pln": 367208817298.7069,
       "rub": 6959193257387.178,
       "sar": 331770503035.5472,
       "sek": 907692119832.3766,
       "sgd": 117533814202.4853,
       "thb": 2992131729409.7705,
       "try": 1723956223308.146,
       "twd": 2714880716317.68,
       "uah": 3254792795561.6045,
       "vef": 8858074648.191938,
       "vnd": 2074300462533515.5,
       "zar": 1617059352874.2566,
       "xdr": 65535774809.539474,
       "xag": 3461506977.038633,
       "xau": 43492412.256972,
       "bits": 3042339216294.478,
       "sats": 304233921629447.8
     },
     "market_cap_percentage": {
       "btc": 45.20539008156504,
       "eth": 18.39087125674645,
       "usdt": 6.581835118595429,
       "bnb": 4.131769965323312,
       "usdc": 2.420911632155965,
       "xrp": 1.9161674139074023,
       "ada": 1.1039584062857009,
       "steth": 0.9576562459301795,
       "doge": 0.8860093918811155,
       "matic": 0.740300484909023
     },
     "market_cap_change_percentage_24h_usd": 1.4910679861977345,
     "updated_at": 1683190243
   }
 }
 
 */
import Foundation

// MARK: - MarketModel
struct GlobalData: Codable {
    let data: MarketDataModel?
}

// MARK: - DataClass
struct MarketDataModel: Codable {
 
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]?
    let marketCapChangePercentage24HUsd: Double?

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap : String{
        if let item = totalMarketCap?.first(where: { $0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume : String {
        if let item = totalVolume?.first(where: { $0.key == "usd" }) {
            return  "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcPercentage : String {
        if let item = marketCapPercentage?.first(where: {$0.key == "btc"}) {
            return item.value.percentStringFormat()
        }
        return ""
    }
}
