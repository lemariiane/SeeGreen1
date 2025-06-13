/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.controller;

/**
 *
 * @author letic
 */
public class Categoria {
    private int id;
    private int idUsuario;
    private String categoria;
    private String cor;
    private double limite;
    
     public Categoria() { 
    }
    
public Categoria(int id, String categoria) {
        this.id = id;
        this.idUsuario = idUsuario;
        this.categoria = categoria;
        this.cor = cor;
        this.limite = limite;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }
    
public String getCor() { return cor; }
public void setCor(String cor) { this.cor = cor; }

public double getLimite() { return limite; }
public void setLimite(double limite) { this.limite = limite; }

    
}
