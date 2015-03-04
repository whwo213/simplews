package com.example.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

/**
 * Created by jinwoo on 2015-03-04.
 */
@Controller
public class MessageController {

    @MessageMapping("/message")
    @SendTo("/topic/message")
    public String message(String message) {
        return message;
    }
}
