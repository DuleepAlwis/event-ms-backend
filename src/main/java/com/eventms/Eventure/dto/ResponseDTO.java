package com.eventms.Eventure.dto;

import lombok.Data;

@Data
public class ResponseDTO {

    private ResponseHeaderDTO responseHeaderDTO;
    private Object responseData;
}
