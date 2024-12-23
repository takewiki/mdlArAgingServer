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
#' blackBillServer()
blackBillServer <- function(input,output,session,erp_token) {
  #一般按纽,用于计数器显示
  var_file_export_baseInfo = tsui::var_file('btn_blackBill')
  text_blackBill_FProjectNumber = tsui::var_text('text_blackBill_FProjectNumber')
  #上传数据
  shiny::observeEvent(input$btn_blackBill_upload,{
    print(1)
    if(is.null(var_file_export_baseInfo())){
      tsui::pop_notice("请先上传文件")

    }else{
      file_name = var_file_export_baseInfo()
      #读取excel------------------------------
      data <- readxl::read_excel(file_name,col_types = c("text", "text", "text"))
      data = as.data.frame(data)

      data = tsdo::na_standard(data)
      #上传服务器----------------
      tsda::db_writeTable2(token = erp_token,table_name = 'rds_t_rule_blackBill',r_object = data,append = TRUE)

      tsui::pop_notice('上传成功')

      #end

    }




  })

  #查询数据

  shiny::observeEvent(input$btn_blackBill_view,{
    print(2)
    data = mdlArAgingPkg::blackBill_view(token = erp_token)
    tsui::run_dataTable2(id ='dt_resultView_blackBill' ,data =data )

  })

  #删除数据

  shiny::observeEvent(input$btn_blackBill_delete,{
    print(3)
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

