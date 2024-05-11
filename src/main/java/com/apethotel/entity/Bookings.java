/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.apethotel.entity;

import java.sql.Timestamp;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 *
 * @author Acer
 */
@ToString
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter

public class Bookings {
    private int bookingId;
    private Pet pet;
    private int cageId;
    private Timestamp startDate;
    private Timestamp endDate;
    private String customerNote;
    private String employeeNote;
    private String petImage;
    private double totalCost;
    private int idStatus;
    private Timestamp bookingDate;

}
