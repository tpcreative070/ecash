//
//  ResponseCodeHelper.swift
//  ecash
//
//  Created by phong070 on 2/12/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import Foundation
//0996
//0998
//1003
//3034
//3024
//3019
//0998
//3014
//3016
//3104
//0001
//0997
//3035
//3035
//3014
//3016
//3104
//3019
//0998
//3019
//3029
//3035
//3035
//3002
//0000
//4009
//4010
//0000
//4008
//4010
//4011
//4012
class ResponseCodeHelper {
//    func mappingErrorCode(code: String, message: String? = nil) -> String {
//         var msg = ""
//
//         switch code {
//
//         case "000" : msg = "Giao dịch thành công"
//         case "001" : msg = "Phiên giao dịch hết thời gian hiệu lực"
//         case "002" : msg = "Lỗi hệ thống"
//         case "003" : msg = "Lỗi hệ thống"
//         case "004" : msg = "Mật khẩu không đúng"
//         case "005" : msg = "Lỗi hệ thống"
//         case "006" : msg = "Lỗi hệ thống"
//         case "007" : msg = "Lỗi hệ thống"
//         case "008" : msg = "Lỗi hệ thống"
//         case "009" : msg = "Lỗi hệ thống"
//         case "010" : msg = "Lỗi hệ thống"
//         case "2013" : msg = "Mã khách hàng không đúng"
//         case "613" : msg = "Qúy khách yêu cầu nhận lại mã quá số lần quy định. Vui lòng thử lại"
//         //<!--Đăng kí ví-->"
//         case "021" : msg = "Tên khách hàng không đúng"
//         case "022" : msg = "Số chứng minh nhân dân không đúng"
//         case "023" : msg = "Mã xác thực không đúng"
//         case "024" : msg = "Mã xác thực không đúng"
//         case "025" : msg = "Số điện thoại không đúng"
//         case "026" : msg = "Tài khoản ví đã tồn tại"
//         case "027" : msg = "Tài khoản ví đã tồn tại"
//         case "120" : msg = "Tài khoản bị khóa trong 30 phút. Vui lòng thử lại sau"
//         case "121" : msg = ""
//         case "122" : msg = "Lỗi hệ thống"
//         case "123" : msg = "Lỗi hệ thống"
//         case "124" : msg = "Xác thực giao dịch thất bại"
//         case "125" : msg = "Lỗi hệ thống"
//         case "126" : msg = "Lỗi hệ thống"
//         case "127" : msg = "Giao dịch không thành công. Vui lòng liên hệ hotline 1900 561 230."
//         case "880" : msg = "Lỗi hệ thống"
//         //<!--Chưa sử dụng--"
//         case "028" : msg = "Giao dịch không thành công. Vui lòng liên hệ hotline 1900 561 230."
//         //<!--case "100" : mGiao dịch không thành công. Vui lòng liên hệ hotline 1900 561 230."
//         case "101" : msg = "Giao dịch không thành công. Vui lòng liên hệ hotline 1900 561 230."
//         //<!--Lỗi chung-->"
//         case "032" : msg = "Tài khoản của bạn bị khóa/đóng. Vui lòng liên hệ hotline 1900 561 230."
//         case "031" : msg = "Tài khoản đã hủy kênh dịch vụ. Vui lòng liên hệ hotline 1900 561 230."
//         //Tai khoan vi da bi"
//         case "035" : msg = "Mật khẩu không đúng"
//         case "030" : msg = "Tài khoản chưa đăng ký"
//         case "037" : msg = "Lỗi hệ thống"
//         case "038" : msg = "Lỗi hệ thống"
//         case "039" : msg = "Phiên hết hạn"
//         case "040" : msg = "Tài khoản ví chưa đăng ký"
//         case "041" : msg = "Tài khoản ví đã bị hủy"
//         case "042" : msg = "Tài khoản ví đã bị khóa"
//         case "043" : msg = "Tài khoản ví chưa được phê duyệt. Vui lòng liên hệ hotline 1900 561 230."
//         case "044" : msg = "Yêu cầu nhận lại mã xác thực quá số lần cho phép."
//         case "045" : msg = "Mã xác thực không đúng."
//         case "046" : msg = "Mã xác thực không đúng"
//         case "047" : msg = "Mã xác thực hết hiệu lực."
//         case "048" : msg = "Mã xác thực đã tồn tại"
//         case "049" : msg = "Lỗi hệ thống"
//         case "050" : msg = "Tài khoản bị từ chối dịch vụ"
//         case "051" : msg = "Tài khoản bị chặn dịch vụ"
//         case "052" : msg = "Giao dịch vượt hạn mức cho phép"
//         case "053" : msg = "Giao dịch vượt hạn mức cho phép"
//         case "054" : msg = "Giao dịch vượt hạn mức cho phép"
//         case "055" : msg = "Số tiền giao dịch tối thiểu là 10.000đ"
//         case "056" : msg = "Số tiền vượt quá tổng hạn mức  trong ngày"
//         case "057" : msg = "Số tiền giao dịch vượt quá tổng hạn mức trong ngày"
//         case "058" : msg = "Giao dịch quá số lần cho phép trong ngày"
//         case "059" : msg = "Giao dịch quá số lần cho phép trong ngày"
//         case "060" : msg = "Số tiền giao dịch vượt quá tổng hạn mức trong ngày"
//         case "061" : msg = "Tài khoản nhận không tồn tại"
//         case "062" : msg = "Tài khoản nhận đã bị hủy"
//         case "063" : msg = "Tài khoản nhận đã bị khóa"
//         case "064" : msg = "Tài khoản nhận không hợp lệ"
//         case "065" : msg = "Tài khoản nhận không hợp lệ"
//         case "066" : msg = "Tài khoản nhận không đúng"
//         case "067" : msg = "Tài khoản nhận đã bị hủy"
//         case "068" : msg = "Tài khoản nhận đã bị khóa"
//         case "069" : msg = "Tài khoản nhận không hợp lệ"
//         case "070" : msg = "Tài khoản nhận không hợp lệ"
//         case "071" : msg = "Lỗi hệ thống"
//         case "072" : msg = "Lỗi hệ thống"
//         case "073" : msg = "Lỗi hệ thống"
//         case "074" : msg = "Lỗi hệ thống"
//         case "075" : msg = "Lỗi hệ thống"
//         case "102" : msg = "Tài khoản chưa xác thực"
//         case "103" : msg = "Tài khoản đã được xác thực"
//         case "104" : msg = "Tài khoản đã được xác thực"
//         case "105" : msg = "Vui lòng upload ảnh CMND"
//         case "106" : msg = "Yêu cầu xác thực tài khoản đã được gửi"
//         case "076" : msg = "Lỗi hệ thống"
//         case "077" : msg = "Lỗi hệ thống"
//         case "078" : msg = "Lỗi hệ thống"
//         case "079" : msg = "Lỗi hệ thống"
//         case "080" : msg = "Lỗi hệ thống"
//         case "081" : msg = "Lỗi hệ thống"
//         case "082" : msg = "Số tiền nạp tối  thiểu là 5.000đ và phải chẵn 1.000đ"
//         case "083" : msg = "Số dư ví không đủ"
//         case "084" : msg = "Lỗi hệ thống"
//         case "085" : msg = "Lỗi hệ thống"
//         case "086" : msg = "Lỗi hệ thống"
//         case "087" : msg = "Tài khoản nhận tiền không được trùng với tài khoản chuyển tiền"
//         case "088" : msg = "Mã khách hàng không đúng"
//         case "089" : msg = "Giao dịch thất bại"
//         case "090" : msg = "Chưa đăng ký tài khoản ngân hàng"
//         case "091" : msg = "Lỗi hệ thống"
//         case "092" : msg = "Lỗi hệ thống"
//         case "093" : msg = "Lỗi hệ thống"
//         case "094" : msg = "giao dịch thất bại"
//         case "095" : msg = "Lỗi hệ thống"
//         case "096" : msg = "Lỗi hệ thống"
//         case "097" : msg = "Lỗi hệ thống"
//         case "098" : msg = "Xử lý như thanh toán trong giờ đóng cổng hiện đang làm"
//         case "099" : msg = "Mã khách hàng thuộc điện lực chưa được hỗ trợ"
//         case "100" : msg = "Giao dịch đã được lưu chờ xử lý"
//         case "202" : msg = "Mã khách hàng đã được đăng ký"
//         case "200" : msg = "Không thể hủy"
//         case "204" : msg = "Giao dịch Rút tiền thất bại"
//         case "205" : msg = "Giao dịch Rút tiền thất bại"
//         case "206" : msg = "Giao dịch Rút tiền thất bại"
//         case "207" : msg = "Chưa có liên kết ngân hàng"
//         case "208" : msg = "Tài khoản ngân hàng không đúng"
//         case "600" : msg = "Tài khoản ví không hợp lệ"
//         case "601" : msg = "Lỗi hệ thống"
//         case "602" : msg = "Tài khoản ví không được sử dụng dịch vụ. Vui lòng liên hệ hotline 1900 561 230"
//         case "603" : msg = "Lỗi hệ thống"
//         case "604" : msg = "Không thể gửi mã xác thực. Vui lòng thử lại."
//         case "605" : msg = "Mã xác thực sẽ được gửi lại sau 60 giây"
//         case "606" : msg = "Mã xác thực không đúng"
//         case "607" : msg = "Mã xác thực không đúng"
//         case "608" : msg = "Mã xác thực không đúng"
//         case "609" : msg = "Mã xác thực không đúng"
//         case "610" : msg = "Mã xác thực không đúng"
//         case "611" : msg = "Không thể gửi mã xác thực. Vui lòng thử lại."
//         case "612" : msg = "Lỗi hệ thống"
//         case "800" : msg = "Lỗi hệ thống"
//         case "801" : msg = "Lỗi hệ thống"
//         case "802" : msg = "Lỗi hệ thống"
//         case "803" : msg = "Lỗi hệ thống"
//         case "804" : msg = "Lỗi hệ thống"
//         case "805" : msg = "Lỗi hệ thống"
//         case "806" : msg = "Số tiền không hợp lệ"
//         case "807" : msg = "Lỗi hệ thống"
//         case "808" : msg = "Lỗi hệ thống"
//         case "809" : msg = "Lỗi hệ thống"
//         case "810" : msg = "Lỗi hệ thống"
//         case "811" : msg = "Hóa đơn đã hết hạn thanh toán"
//         case "812" : msg = "Hóa đơn không tồn tại"
//         case "813" : msg = "Mã khách hàng không đúng"
//         case "814" : msg = "Lỗi hệ thống"
//         case "815" : msg = "Lỗi hệ thống"
//         case "816" : msg = "Lỗi hệ thống"
//         case "817" : msg = "Lỗi hệ thống"
//         case "818" : msg = "Khách hàng hết nợ"
//         case "819" : msg = "Phiên giao dịch hết thời gian hiệu lực"
//         case "820" : msg = ""
//         case "821" : msg = "Lỗi hệ thống"
//         case "822" : msg = "Lỗi hệ thống"
//         case "823" : msg = "lỗi kết nối"
//         case "824" : msg = "Lỗi hệ thống"
//         case "825" : msg = "Hóa đơn đã được thanh toán"
//         case "826" : msg = "Mật khẩu không đúng"
//         case "827" : msg = "Lỗi hệ thống"
//         case "828" : msg = "Lỗi hệ thống"
//         case "829" : msg = "Lỗi hệ thống"
//         case "830" : msg = "Phiên giao dịch hết thời gian hiệu lực"
//         case "831" : msg = "Lỗi hệ thống"
//         case "832" : msg = "Lỗi hệ thống"
//         case "833" : msg = "Lỗi hệ thống"
//         case "834" : msg = "Lỗi hệ thống"
//         case "835" : msg = "Lỗi hệ thống"
//         case "836" : msg = "Hạn mức giao dịch tối đa là 10.000.000đ"
//         case "837" : msg = "Số tiền giao dịch tối thiểu là 5.000đ, tối đa là 1.000.000đ và phải chẵn 500đ"
//         case "838" : msg = "Số tiền thanh toán tối thiểu là 1.000đ và phải chẵn 1.000đ"
//         case "839" : msg = "Thuê bao ngừng hoạt động"
//         case "840" : msg = "Lỗi hệ thống"
//         case "841" : msg = "Tài khoản không được thanh toán. Vui lòng liên hệ hotline 1900 561 230"
//         case "842" : msg = "Số điện thoại nạp tiền không phải thuê bao trả sau"
//         case "843" : msg = "Mã khách hàng/số hợp đồng không đúng"
//         case "844" : msg = "Lỗi hệ thống"
//         case "845" : msg = "Lỗi hệ thống"
//         case "846" : msg = "Lỗi hệ thống"
//         case "847" : msg = "Lỗi hệ thống"
//         case "848" : msg = "Giao dịch đang xử lý"
//         case "849" : msg = "Lỗi hệ thống"
//         case "850" : msg = "Lỗi hệ thống"
//         case "851" : msg = "Lỗi hệ thống"
//         case "852" : msg = "Lỗi hệ thống"
//         case "853" : msg = "Lỗi hệ thống"
//         case "854" : msg = "Lỗi hệ thống"
//         case "855" : msg = "Lỗi hệ thống"
//         case "856" : msg = "Lỗi hệ thống"
//         case "857" : msg = "Lỗi hệ thống"
//         case "858" : msg = "Lỗi hệ thống"
//         case "859" : msg = "Lỗi hệ thống"
//         case "860" : msg = "Lỗi hệ thống"
//         case "861" : msg = "Lỗi hệ thống"
//         case "862" : msg = "Lỗi hệ thống"
//         case "863" : msg = "Lỗi hệ thống"
//         case "864" : msg = "Lỗi hệ thống"
//         case "865" : msg = "Lỗi hệ thống"
//         case "866" : msg = "Lỗi hệ thống"
//         case "867" : msg = "Số dư ví không đủ"
//         case "868" : msg = "Lỗi hệ thống"
//         case "869" : msg = "Lỗi hệ thống"
//         case "870" : msg = "Lỗi hệ thống"
//         case "871" : msg = "Lỗi hệ thống"
//         case "872" : msg = "Tài khoản nạp tiền không đúng"
//         case "873" : msg = "Lỗi hệ thống"
//         case "874" : msg = "Tài khoản nhận tiền không đúng"
//         case "877" : msg = "Dịch vụ đang bảo trì, vui lòng quay lại sau"
//         case "900" : msg = "Lỗi hệ thống"
//         case "998" : msg = "Lỗi hệ thống"
//         case "999" : msg = "Lỗi hệ thống"
//         case "107" : msg = "Tài khoản người giới thiệu không đúng"
//         case "116" : msg = "Đã nhập mã giới thiệu"
//         case "209" : msg = "Chưa liên kết ngân hàng"
//         case "020" : msg = "Tài khoản ví không có quyền truy cập"
//         case "112" : msg = "Giao dịch vượt hạn mức cho phép"
//         case "1003" : msg = "Lỗi hệ thống"
//         case "0017" : msg = "Không có thông tin khách hàng"
//         case "0005": msg = "Thuê bao không đúng"
//         case "0009": msg = "Số hợp đồng không đúng"
//         case "0099": msg = "Thuê bao ngừng hoạt động"
//
//         //==== lỗi thanh toán nước ==================
//
//         case "404" : msg = "Hóa đơn không tồn tại"
//         case "9006" : msg = "Time out tới core"
//
//         case "0025" : msg = "Khách hàng hết nợ"
//
//         default:
//            msg = "Lỗi hệ thống. Vui lòng thử lại"
//         }
//         return msg
//     }
    
//    class func mappingErrorCode(code: String) -> String {
//        switch code {
//        case EnumResponseCode.EXISTING_VALUE.rawValue :
//            return getTranslationByKey(LanguageKey.TransactionSuccessful)!
//        case EnumResponseCode.OTP_INCORRECT.rawValue :
//            return getTranslationByKey(LanguageKey.OTPIncorrect)!
//
//        default:
//            return getTranslationByKey(LanguageKey.Error)!
//        }
//    }
}
