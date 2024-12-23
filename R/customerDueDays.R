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
#' customerDueDaysuploadServer()
customerDueDaysuploadServer <- function(input,output,session,erp_token) {
  #一般按纽,用于计数器显示
  var_file_export_baseInfo = tsui::var_file('btn_customerDueDays')
  text_customerDueDays_FCustomerNumber = tsui::var_text('text_customerDueDays_FCustomerNumber')


  #上传数据
  shiny::observeEvent(input$btn_customerDueDays_upload,{
    if(is.null(var_file_export_baseInfo())){
      tsui::pop_notice("请先上传文件")

    }else{
      file_name = var_file_export_baseInfo()
      mdlArAgingPkg::customerDueDays_upload(token = erp_token,file_name =file_name )

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
#' customerDueDaysviewServer()
customerDueDaysviewServer <- function(input,output,session,erp_token) {

  #查询数据

  shiny::observeEvent(input$btn_customerDueDays_view,{
    data = mdlArAgingPkg::customerDueDays_view(token = erp_token)
    tsui::run_dataTable2(id ='dt_resultView_customerDueDays' ,data =data )

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
#' customerDueDaysdeleteServer()
customerDueDaysdeleteServer <- function(input,output,session,erp_token) {
  text_customerDueDays_FCustomerNumber = tsui::var_text('text_customerDueDays_FCustomerNumber')

  #删除数据

  shiny::observeEvent(input$btn_customerDueDays_delete,{
    if(text_customerDueDays_FCustomerNumber() == ''){
      tsui::pop_notice("请填写需要删除的项目号")

    }else{

      FCustomerNumber=text_customerDueDays_FCustomerNumber()
      data = mdlArAgingPkg::customerDueDays_delete(token = erp_token,FCustomerNumber =FCustomerNumber )
      tsui::run_dataTable2(id ='dt_resultView_customerDueDays' ,data =data )
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
#' customerDueDaysServer()
customerDueDaysServer <- function(input,output,session,erp_token) {
  mdlArAgingServer::customerDueDaysdeleteServer(input =input ,output = output,session =session ,erp_token =erp_token)
  mdlArAgingServer::customerDueDaysuploadServer(input =input ,output = output,session =session ,erp_token =erp_token)

  mdlArAgingServer::customerDueDaysviewServer(input =input ,output = output,session =session ,erp_token =erp_token)

}










