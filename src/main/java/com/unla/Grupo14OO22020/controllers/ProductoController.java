package com.unla.Grupo14OO22020.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.unla.Grupo14OO22020.entities.Producto;
import com.unla.Grupo14OO22020.helpers.ViewRouteHelpers;
import com.unla.Grupo14OO22020.models.ProductoModel;
import com.unla.Grupo14OO22020.services.IProductoService;

@Controller
@RequestMapping("/productos")
public class ProductoController {
	
	@Autowired
	@Qualifier("productoService")
	private IProductoService productoService;
	
	@GetMapping("")
	public ModelAndView index() {
		ModelAndView mAV = new ModelAndView(ViewRouteHelpers.PRODUCTO_INDEX);
		mAV.addObject("productos", productoService.getAll());
		mAV.addObject("producto", new ProductoModel());
		
		return mAV;
	}
	
	@GetMapping("/new")
	public ModelAndView crear() {
		ModelAndView mAV = new ModelAndView(ViewRouteHelpers.PRODUCTO_ADD);
		mAV.addObject("producto", new Producto());
		
		return mAV;
	}
	
	@PostMapping("/create")
	public RedirectView agregar(@ModelAttribute(name="productos") ProductoModel producto ) {
		productoService.insertOrUpdate(producto);
		return new RedirectView(ViewRouteHelpers.PRODUCTO_ROOT);
	}
	
	@PostMapping("/delete/{id}")
	public RedirectView eliminar(@PathVariable("id") int id) {
		productoService.remove(id);
		return new RedirectView(ViewRouteHelpers.PRODUCTO_ROOT);
	}
	
	@GetMapping("/{id}")
	public ModelAndView get(@PathVariable("id") int idProducto) {
		ModelAndView mAV = new ModelAndView(ViewRouteHelpers.PRODUCTO_UPDATE);
		mAV.addObject("producto", productoService.findByIdProducto(idProducto));
		return mAV;
	}
	
	@PostMapping("/update")
	public RedirectView update(@ModelAttribute("producto") ProductoModel productoModel) {
		productoService.insertOrUpdate(productoModel);
		return new RedirectView(ViewRouteHelpers.PRODUCTO_ROOT);
	}

}//Fin class
