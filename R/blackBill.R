#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param erp_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' blackBilluploadServer()
blackBilluploadServer <- function(input,output,session,erp_token) {
  #一般按纽,用于计数器显示
  var_file_export_baseInfo = tsui::var_file('btn_blackBill')
  text_blackBill_FProjectNumber = tsui::var_text('text_blackBill_FProjectNumber')


  #上传数据
  shiny::observeEvent(input$btn_blackBill_upload,{
    if(is.null(var_file_export_baseInfo())){
      tsui::pop_notice("请先上传文件")

    }else{
      file_name = var_file_export_baseInfo()
      mdlArAgingPkg::blackBill_upload(token = erp_token,file_name =file_name )

      tsui::pop_notice('上传成功')
    }



  })



}

#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param erp_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' blackBillviewServer()
blackBillviewServer <- function(input,output,session,erp_token) {

  #查询数据

  shiny::observeEvent(input$btn_blackBill_view,{
    data = mdlArAgingPkg::blackBill_view(token = erp_token)
    tsui::run_dataTable2(id ='dt_resultView_blackBill' ,data =data )

  })



}



#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param erp_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' blackBilldeleteServer()
blackBilldeleteServer <- function(input,output,session,erp_token) {
  text_blackBill_FProjectNumber = tsui::var_text('text_blackBill_FProjectNumber')

  #删除数据

  shiny::observeEvent(input$btn_blackBill_delete,{
    if(text_blackBill_FProjectNumber() == ''){
      tsui::pop_notice("请填写需要删除的项目号")

    }else{

      FProjectNumber=text_blackBill_FProjectNumber()
      data = mdlArAgingPkg::blackBill_delete(token = erp_token,FProjectNumber =FProjectNumber )
      tsui::run_dataTable2(id ='dt_resultView_blackBill' ,data =data )
      tsui::pop_notice("删除成功")

    }



  })

}






#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param erp_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' blackBillServer()
blackBillServer <- function(input,output,session,erp_token) {
  mdlArAgingServer::blackBilldeleteServer(input =input ,output = output,session =session ,erp_token =erp_token)
  mdlArAgingServer::blackBilluploadServer(input =input ,output = output,session =session ,erp_token =erp_token)

  mdlArAgingServer::blackBillviewServer(input =input ,output = output,session =session ,erp_token =erp_token)

}










