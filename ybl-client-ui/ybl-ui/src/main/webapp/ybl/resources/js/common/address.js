//初始化省市区镇下拉框（省selectID,市selectID,区selectID,默认值:1、全部,0、请选择,是否包含全国：true包含）
function initAddressSelect(provice, city, area, defaultValue_1, nationwide) {
	if (defaultValue_1 != null || defaultValue_1 != '')
		defaultValue_ = defaultValue_1;
	// 获取省份列表
	$
			.ajax({
				cache : true,
				type : "POST",
				url : '/address/province/queryAllProvince',
				async : false,
				dataType : 'json',
				error : function(request) {
					alert('获取省份列表失败！');
				},
				success : function(data) {
					var provinceEntryList = data;
					// 含全国
					if (nationwide) {
						provinceEntryList = AddNation(provinceEntryList);
					}
					if (provice != undefined && provice != '') {
						updateAddressOptions(provice, provinceEntryList,
								defaultValue_);
					}
					if (city != undefined && city != '')
						updateAddressOptions(city, null, defaultValue_);

					if (area != undefined && area != '')
						updateAddressOptions(area, null, defaultValue_);
				}
			});
	// 如果是查询则填充
	if ($("#"+provice+"_code").val() != null && $("#"+provice+"_code").val() != '') {
		var provinceId = $("#"+provice+"_code").val();
		var cityId = $("#"+city+"_code").val();
		var areaId = $("#"+area+"_code").val();
		$("#"+provice).val(provinceId);
		$("#"+provice).trigger("change");
		$("#"+city).val(cityId);
		$("#"+city).trigger("change");
		$("#"+area).val(areaId);
	}
}

/**
 * 添加全国选项
 * 
 * @param provinces
 */
function AddNation(provinces) {
	if (provinces == null)
		return null;
	var l_index = provinces.length;
	provinces = provinces.reverse();
	provinces[l_index] = {
		code : "00",
		name : "全国"
	};
	return provinces.reverse();
}

// 省下拉框选择响应事件（省select对象,市selectID,区selectID）
function selectProvince(obj, city, area) {
	var proviceCode = $(obj).val();
	if (proviceCode == undefined || proviceCode == '') {
		$("#" + city).get(0).selectedIndex = 0;
		if ($("#" + area).get(0) != undefined) {
			$("#" + area).get(0).selectedIndex = 0;
		}
		return;
	} else if (proviceCode == '00') {
		$("#" + city).get(0).selectedIndex = 0;
		if ($("#" + area).get(0) != undefined) {
			$("#" + area).get(0).selectedIndex = 0;
		}
		/*
		 * when select "全国" as province,should disable both city and area if
		 * city and area showed
		 */
		$("#" + city).prop({
			disabled : true
		});
		$("#" + area).prop({
			disabled : true
		});
		return;
	} else {
		$("#" + city).prop({
			disabled : false
		});
		$("#" + area).prop({
			disabled : false
		});
		if (area != undefined && $.trim(area).length > 0) {
			$("#" + area).get(0).selectedIndex = 0;
		}
	}
	// 获取市份列表
	$.ajax({
		type : "POST",
		url : '/address/city/queryCityByProvinceId',
		data : {
			'provinceId' : proviceCode
		},
		dataType : 'json',
		async : false,
		error : function(request) {
			alert('获取地市列表失败！');
		},
		success : function(data) {
			var cityEntryList = data
			if (cityEntryList != undefined && cityEntryList != '') {
				updateAddressOptions(city, cityEntryList);
			}
		}
	});
}

// 市下拉框选择响应事件（市select对象,区selectID）
function selectCity(obj, area) {
	var cityCode = $(obj).val();
	if (cityCode == undefined || cityCode == '') {
		return;
	}
	// 获取区列表
	$.ajax({
		type : "POST",
		url : '/address/area/queryAreaBycityId',
		data : {
			'cityId' : cityCode
		},
		dataType : 'json',
		async : false,
		error : function(request) {
			alert('获取区县列表失败！');
		},
		success : function(data) {
			var areaEntryList = data;
			if (area != undefined && area != '') {
				updateAddressOptions(area, areaEntryList);
			}
		}
	});
}

var defaultValue_1;
// 更新地址下拉框的选项defaultValue 1:全部 2:请选择
function updateAddressOptions(selectId, result, defaultValue_) {
	if (defaultValue_)
		defaultValue_ = defaultValue_;
	defaultValue_ = defaultValue_ || defaultValue_1;
	$("#" + selectId + " option").remove();
	var select = document.getElementById(selectId);
	var option
	if (defaultValue_ == 1) {
		option = new Option("--全部--", "");
	} else {
		option = new Option("--请选择--", "");
	}
	select.options.add(option);
	if (result == undefined) {
		return;
	}
	for (var i = 0; i < result.length; i++) {
		option = new Option(result[i].name_, result[i].id_);
		select.options.add(option);
	}
}
//根据省市区code查询省市区名称
function selectAddress(provice, city, area, address) {
	var provinceCode = (provice == '' || provice == null ? $("#provinceId")
			.val() : provice);
	var cityCode = (city == '' || city == null ? $("#cityId").val() : city);
	var areaCode = (area == '' || area == null ? $("#areaId").val() : area);
	var address = (address == '' || address == null ? $("#address").val()
			: address);
	// 获取省份列表
	$.ajax({
		type : "POST",
		url : '/address/splitAddress',
		async : false,
		data : {
			provinceCode : provinceCode,
			cityCode : cityCode,
			areaCode : areaCode,
			address : address
		},
		error : function(request) {

		},
		success : function(data) {
			if (data != null && data != '') {
				var addressArr = data.split("-");
				$("#provinceId")
						.val(addressArr[0] != null ? addressArr[0] : "");
				$("#cityId").val(addressArr[1] != null ? addressArr[1] : "");
				$("#areaId").val(addressArr[2] != null ? addressArr[2] : "");
				return data;
			}
		}
	});
	return '';
}