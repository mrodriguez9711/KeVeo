package com.example.KeVeo.data.entity;

import org.springframework.http.converter.json.GsonBuilderUtils;

import javax.persistence.*;
import java.util.Date;

@Entity
public class BillEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "billId")
    private Integer id;

    @Column(name = "billName")
    private String name;

    @Column(name = "billDate")
    private Date date;
    public BillEntity() {
    }
}
