<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>


<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">일일 경비 입력</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
		
			<div class="panel-heading">일일 경비 입력</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
			
				<form role="form" action="/daybud/register" method="post">

					<div class="form-group">
						<label>SCHNO</label> <input class="form-control" name='schno'>
					</div>

					<div class="form-group">
						<label>PAYDATE</label>
						<div>
							<input type="date" class="form-control" name='paydate'/>
						</div>
					</div>

					<div class="form-group">
						<label>DAYPAY</label> <input class="form-control" name='daypay'>
					</div>

					<div class="form-group">
						<label>DAYCNT</label> <input class="form-control" name='daycnt'>
					</div>

					<button type="submit" class="btn btn-default">등록</button>
					<button type="reset" class="btn btn-default">초기화</button>
					
					</form>
					
			</div>
			<!-- end panel-body -->
		</div>
		<!-- end panel -->
	</div>
</div>
<!-- /.row -->

<%@include file="../includes/footer.jsp"%>
