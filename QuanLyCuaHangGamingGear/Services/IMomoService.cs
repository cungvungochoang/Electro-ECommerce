
using QuanLyCuaHangGamingGear.Models.Momo;
using QuanLyCuaHangGamingGear.Models.Order;

namespace QuanLyCuaHangGamingGear.Services;

public interface IMomoService
{
    Task<MomoCreatePaymentResponseModel> CreatePaymentAsync(OrderInfoModel model);
    MomoExecuteResponseModel PaymentExecuteAsync(IQueryCollection collection);
}