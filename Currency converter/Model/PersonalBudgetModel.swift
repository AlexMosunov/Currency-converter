//
//  PersonalBudgetModel.swift
//  Currency converter
//
//  Created by Alex Mosunov on 26.10.2021.
//

import Foundation
import Alamofire


struct PersonalBudgetModel {
    
    enum Category: String, CaseIterable {
        case dutyFree             = "Duty Free"
        case flights              = "Авіаквитки"
        case carService           = "Автосервіс"
        case gasStation           = "АЗС"
        case pharmacy             = "Аптеки"
        case shoes                = "Взуття"
        case wineMarkets          = "Виномаркети"
        case houseStuff           = "Все для дому"
        case hotels               = "Готелі"
        case childrenGoods        = "Дитячі товари"
        case petShops             = "Зоомагазини"
        case gamesAndApplications = "Ігри та додатки"
        case restaurants          = "Кафе та ресторани"
        case flowers              = "Квіти"
        case cinemasAndTheaters   = "Кіно та театри"
        case books                = "Книги"
        case confectionery        = "Кондитерські"
        case beautyAndCare        = "Краса та догляд"
        case marketplaces         = "Маркетплейси"
        case medicalInstitutions  = "Медзаклади"
        case clothes              = "Одяг"
        case groceries            = "Продукти"
        case entertainments       = "Розваги"
        case sportAndFitness      = "Спорт та фітнес"
        case taxi                 = "Таксі"
        case appliances           = "Техніка"
        case transport            = "Транспорт"
        case dryCleaning          = "Хімчистки"
        case other                = "Інше"
    }
    
    let categories = Category.allCases
    
    func getCategoryWith(code: Int32) -> Category {
        switch code {
        case 5309:
            return .dutyFree
        case 3002, 3003, 3004, 3014, 3019, 3021, 3023, 3024, 3027, 3030, 3031, 3036, 3038, 3040, 3041, 3044, 3045, 3046, 3049, 3053, 3054, 3055, 3059, 3060, 3061, 3062, 3065, 3067, 3068, 3069, 3071, 3072, 3073, 3078, 3081, 3083, 3084, 3085, 3086, 3087, 3090, 3092, 3093, 3094, 3095, 3096, 3097, 3098, 3101, 3104, 3105, 3106, 3107, 3109, 3110, 3111, 3112, 3113, 3114, 3115, 3116, 3117, 3118, 3119, 3120, 3121, 3122, 3123, 3124, 3125, 3126, 3128, 3129, 3130, 3131, 3133, 3134, 3135, 3137, 3138, 3139, 3140, 3141, 3142, 3143, 3145, 3146, 3147, 3148, 3150, 3151, 3152, 3153, 3154, 3155, 3156, 3157, 3158, 3159, 3160, 3161, 3162, 3163, 3164, 3165, 3166, 3167, 3168, 3169, 3170, 3171, 3172, 3173, 3175, 3176, 3177, 3178, 3179, 3185, 3186, 3187, 3188, 3189, 3190, 3191, 3192, 3193, 3194, 3195, 3197, 3198, 3199, 3200, 3201, 3202, 3203, 3204, 3205, 3207, 3208, 3209, 3210, 3211, 3212, 3213, 3214, 3215, 3216, 3218, 3219, 3220, 3221, 3222, 3223, 3224, 3225, 3226, 3227, 3228, 3229, 3230, 3231, 3232, 3233, 3234, 3235, 3237, 3238, 3239, 3240, 3241, 3242, 3243, 3244, 3249, 3250, 3251, 3252, 3253, 3254, 3257, 3258, 3259, 3262, 3263, 3264, 3265, 3267, 3268, 3270, 3274, 3275, 3276, 3277, 3278, 3279, 3280, 3281, 3282, 3283, 3284, 3285, 3286, 3287, 3288, 3289, 3290, 3291, 3292, 3293, 3294, 3296, 3298, 3301, 3000, 3001, 3005, 3006, 3007, 3008, 3009, 3010, 3011, 3012, 3013, 3015, 3016, 3017, 3018, 3020, 3022, 3025, 3026, 3028, 3029, 3032, 3033, 3034, 3035, 3037, 3039, 3042, 3043, 3047, 3048, 3050, 3051, 3052, 3056, 3057, 3058, 3063, 3064, 3066, 3075, 3076, 3077, 3079, 3082, 3088, 3089, 3099, 3100, 3102, 3103, 3127, 3132, 3136, 3144, 3174, 3180, 3181, 3182, 3183, 3184, 3196, 3206, 3217, 3236, 3245, 3246, 3247, 3248, 3256, 3260, 3261, 3266, 3295, 3297, 3299, 4511:
            return .flights
        case 5511, 5531, 5532, 5533, 7531, 7534, 7535, 7538, 7542:
            return .carService
        case 5172, 5541, 5542, 5983:
            return .gasStation
        case 5122, 5292, 5295, 5912:
            return .pharmacy
        case 5139, 5661:
            return .shoes
        case 5921:
            return .wineMarkets
        case 5131, 5200, 5211, 5231, 5712, 5713, 5719:
            return .houseStuff
        case 3507, 3511, 3514, 3517, 3521, 3522, 3523, 3524, 3525, 3526, 3527, 3529, 3531, 3532, 3534, 3537, 3538, 3539, 3540, 3545, 3546, 3547, 3549, 3550, 3551, 3554, 3556, 3557, 3558, 3559, 3560, 3561, 3563, 3564, 3565, 3566, 3567, 3568, 3570, 3571, 3572, 3573, 3574, 3575, 3576, 3578, 3580, 3582, 3587, 3588, 3589, 3593, 3594, 3595, 3597, 3598, 3599, 3600, 3601, 3602, 3603, 3604, 3605, 3606, 3607, 3608, 3609, 3610, 3611, 3613, 3614, 3616, 3617, 3618, 3619, 3620, 3621, 3622, 3624, 3626, 3627, 3630, 3631, 3632, 3633, 3636, 3639, 3645, 3646, 3647, 3648, 3656, 3658, 3660, 3663, 3664, 3666, 3669, 3670, 3671, 3673, 3674, 3675, 3676, 3677, 3679, 3680, 3681, 3682, 3683, 3685, 3686, 3688, 3689, 3691, 3694, 3696, 3697, 3699, 3701, 3702, 3704, 3705, 3706, 3707, 3708, 3711, 3712, 3713, 3714, 3717, 3718, 3719, 3720, 3724, 3725, 3726, 3727, 3728, 3729, 3731, 3732, 3733, 3734, 3735, 3736, 3738, 3739, 3742, 3743, 3745, 3746, 3747, 3748, 3749, 3751, 3752, 3753, 3755, 3756, 3758, 3759, 3760, 3761, 3762, 3763, 3764, 3766, 3767, 3768, 3772, 3774, 3775, 3776, 3780, 3781, 3782, 3783, 3784, 3785, 3786, 3787, 3788, 3789, 3791, 3792, 3794, 3796, 3797, 3798, 3799, 3816, 3828, 3830, 3831, 3501, 3502, 3503, 3504, 3505, 3506, 3508, 3509, 3510, 3512, 3513, 3515, 3516, 3518, 3519, 3520, 3528, 3530, 3533, 3535, 3536, 3541, 3542, 3543, 3544, 3548, 3552, 3553, 3555, 3562, 3569, 3577, 3579, 3581, 3583, 3584, 3585, 3586, 3590, 3591, 3592, 3596, 3612, 3615, 3623, 3625, 3628, 3629, 3634, 3635, 3637, 3638, 3640, 3641, 3642, 3643, 3644, 3649, 3650, 3651, 3652, 3653, 3654, 3655, 3657, 3659, 3661, 3662, 3665, 3667, 3668, 3672, 3678, 3684, 3687, 3690, 3692, 3693, 3695, 3698, 3700, 3703, 3709, 3710, 3715, 3716, 3721, 3722, 3723, 3730, 3737, 3740, 3741, 3744, 3750, 3754, 3757, 3765, 3769, 3770, 3771, 3773, 3777, 3778, 3779, 3790, 3793, 3795, 7011:
            return .hotels
        case 5641, 5945:
            return .childrenGoods
        case 0742, 5995:
            return .petShops
        case 5816, 5815, 5817:
            return .gamesAndApplications
        case 5811, 5812, 5813, 5814:
            return .restaurants
        case 5992, 5193, 5261, 0780:
            return .flowers
        case 7829, 7832, 7922:
            return .cinemasAndTheaters
        case 5192, 5942, 5943, 5949, 5970:
            return .books
        case 5441, 5462:
            return .confectionery
        case 7230, 7297, 7298, 5331, 5977:
            return .beautyAndCare
        case 5300, 5964, 5310, 5311, 5399, 5999:
            return .marketplaces
        case 4119, 8011, 8021, 8031, 8041, 8042, 8043, 8049, 8050, 8062, 8071, 8099:
            return .medicalInstitutions
        case 5137, 5611, 5621, 5651, 5681, 5691, 5699, 5931:
            return .clothes
        case 5411, 5412, 5422, 5451, 5499:
            return .groceries
        case 7932, 7933, 7996, 7998, 7999, 5733, 5818, 7841, 7993, 7221, 7395:
            return .entertainments
        case 5655, 5940, 5941, 7911, 7941, 7992, 7997:
            return .sportAndFitness
        case 4121:
            return .taxi
        case 4812, 5722, 5732, 5946:
            return .appliances
        case 4131, 4111, 4112:
            return .transport
        case 7216, 7210, 7211, 7251, 7217:
            return .dryCleaning
        default:
            return .other
        }
    }
    
    var amountPerCategory: [Category : Float] = [:]
    
    var transactionsPerCategory: [Category : [UserTransaction]] = [:]
    
    var categoriesWithValue = [Category]()
    
    
    mutating func fetchUserTransactions(_ transactions: [UserTransaction]) -> String {
        var amount: Float       = 0
        amountPerCategory       = [:]
        transactionsPerCategory = [:]
        categoriesWithValue     = []
        
        for transaction in transactions {
            
            if let code = transaction.mcc {
                let category = self.getCategoryWith(code: code)
                if amountPerCategory[category] != nil {
                    amountPerCategory[category]! += Float((transaction.amount! / 100))
                    transactionsPerCategory[category]?.append(transaction)

                } else {
                    amountPerCategory[category] = Float((transaction.amount! / 100))
                    categoriesWithValue.append(category)
                    transactionsPerCategory[category] = [transaction]

                }
            }
            
            if let tAmount = transaction.amount {
                amount += Float(tAmount / 100)
            }
        }
        return String(Int(amount))
    }
    
}
