#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' customerDueDaysServer()
customerDueDaysServer <- function(input,output,session,erp_token) {
  #一般按纽,用于计数器显示
  #一般按纽,用于计数器显示
  var_file_export_baseInfo = tsui::var_file('btn_customerDueDays')
  text_customerDueDays_FCustomerNumber = tsui::var_text('text_customerDueDays_FCustomerNumber')
  #上传数据
  shiny::observeEvent(input$btn_customerDueDays_upload,{
    print(1)
    if(is.null(var_file_export_baseInfo())){
      tsui::pop_notice("请先上传文件")

    }else{
      file_name = var_file_export_baseInfo()
      #读取excel------------------------------
      data <- readxl::read_excel(file_name,col_types = c("text", "text", "numeric", "numeric", "numeric", "text", "text",

      ))
      data = as.data.frame(data)

      data = tsdo::na_standard(data)
      #上传服务器----------------
      tsda::db_writeTable2(token = erp_token,table_name = 'rds_t_rule_customerDueDays',r_object = data,append = TRUE)

      tsui::pop_notice('上传成功')

      #end

    }




  })

  #查询数据

  shiny::observeEvent(input$btn_customerDueDays_view,{
    print(2)
    data = mdlArAgingPkg::customerDueDays_view(token = erp_token)
    tsui::run_dataTable2(id ='dt_resultView_customerDueDays' ,data =data )

  })

  #删除数据

  shiny::observeEvent(input$btn_customerDueDays_delete,{
    print(3)
    if(text_customerDueDays_FCustomerNumber() == ''){
      tsui::pop_notice("请填写需要删除的客户代码")

    }else{

      FCustomerNumber=text_customerDueDays_FCustomerNumber()
      data = mdlArAgingPkg::customerDueDays_delete(token = erp_token,FCustomerNumber =FCustomerNumber )
      tsui::run_dataTable2(id ='dt_resultView_customerDueDays' ,data =data )
      tsui::pop_notice("删除成功")

    }



  })

}

