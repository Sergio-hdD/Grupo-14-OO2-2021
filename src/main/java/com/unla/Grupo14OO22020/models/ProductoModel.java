package com.unla.Grupo14OO22020.models;

import java.time.LocalDate;

public class ProductoModel {
	private int idProducto;
	private String nombre;
	private String descripcion;
	private float precio;
	private LocalDate fechaAlta;

	public ProductoModel() { }

	public ProductoModel(int idProducto, String nombre, String descripcion, float precio, LocalDate fechaAlta) {
		super();
		this.idProducto = idProducto;
		this.nombre = nombre;
		this.descripcion = descripcion;
		this.precio = precio;
		this.fechaAlta = fechaAlta;
	}



	public int getIdProducto() {
		return idProducto;
	}

	public void setIdProducto(int idProducto) {
		this.idProducto = idProducto;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public float getPrecio() {
		return precio;
	}

	public void setPrecio(float precio) {
		this.precio = precio;
	}

	public LocalDate getFechaAlta() {
		return fechaAlta;
	}

	public void setFechaAlta(LocalDate fechaAlta) {
		this.fechaAlta = fechaAlta;
	}

	@Override
	public String toString() {
		return "ProductoModel [idProducto=" + idProducto + ", nombre=" + nombre + "]";
	}

}//Fin class
