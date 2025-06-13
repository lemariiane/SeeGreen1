/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.controller;

import java.time.LocalDate;

/**
 *
 * @author letic
 */
public class Receita {
    private int id;
    private String descricao;
    private double valor;
    private LocalDate datareceita;
    private int idUsuario;
    private int idTipoReceita;
    private TipoReceita tipoReceita;

public TipoReceita getTipoReceita() {
    return tipoReceita;
}

public void setTipoReceita(TipoReceita tipoReceita) {
    this.tipoReceita = tipoReceita;
}


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public double getValor() {
        return valor;
    }

    public void setValor(double valor) {
        this.valor = valor;
    }

    public LocalDate getDatareceita() {
        return datareceita;
    }

    public void setDatareceita(LocalDate datareceita) {
        this.datareceita = datareceita;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public int getIdTipoReceita() {
        return idTipoReceita;
    }

    public void setIdTipoReceita(int idTipoReceita) {
        this.idTipoReceita = idTipoReceita;
    }
    
}
