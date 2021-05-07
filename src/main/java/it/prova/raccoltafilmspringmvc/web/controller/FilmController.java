package it.prova.raccoltafilmspringmvc.web.controller;

import java.util.List;

import javax.validation.Valid;

import it.prova.raccoltafilmspringmvc.model.Regista;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import it.prova.raccoltafilmspringmvc.model.Film;
import it.prova.raccoltafilmspringmvc.service.FilmService;
import it.prova.raccoltafilmspringmvc.service.RegistaService;

@Controller
@RequestMapping(value = "/film")
public class FilmController {

	@Autowired
	private FilmService filmService;
	@Autowired
	private RegistaService registaService;

	@GetMapping
	public ModelAndView listAllFilms() {
		ModelAndView mv = new ModelAndView();
		List<Film> films = filmService.listAllElements();
		mv.addObject("film_list_attribute", films);
		mv.setViewName("film/list");
		return mv;
	}

	@GetMapping("/insert")
	public String createFilm(Model model) {
		model.addAttribute("insert_film_attr", new Film());
		return "film/insert";
	}

	@PostMapping("/save")
	public String saveFilm(@Valid @ModelAttribute("insert_film_attr") Film film, BindingResult result,
			RedirectAttributes redirectAttrs) {

		// se il regista è valorizzato dobbiamo provare a caricarlo perché
		// ci aiuta in pagina
		if (film.getRegista() != null && film.getRegista().getId() != null)
			film.setRegista(registaService.caricaSingoloElemento(film.getRegista().getId()));
		else
			result.rejectValue("regista", "regista.notnull");

		if (result.hasErrors()) {
			return "film/insert";
		}
		filmService.inserisciNuovo(film);

		redirectAttrs.addFlashAttribute("successMessage", "Operazione eseguita correttamente");
		return "redirect:/film";
	}

	@GetMapping("/search")
	public String searchFilm() {
		return "film/search";
	}

	@PostMapping("/list")
	public String listRegisti(Film filmExample, ModelMap model) {
		List<Film> films = filmService.findByExample(filmExample);
		model.addAttribute("film_list_attribute", films);
		return "film/list";
	}

	@GetMapping("/show/{idFilm}")
	public String showFilm(@PathVariable(required = true) Long idFilm, Model model) {
		model.addAttribute("show_film_attr", filmService.caricaSingoloElementoEager(idFilm));
		return "film/show";
	}
	@GetMapping("/edit/{idFilm}")
	public String editFilm(@PathVariable(required = true) Long idFilm, Model model   ) {
		Film filmToUpdate = filmService.caricaSingoloElementoEager(idFilm);
		List<Regista> registi = registaService.listAllElements();
		model.addAttribute("edit_film_attr", filmToUpdate);
		model.addAttribute("registi_list_attribute", registi);

		return "film/edit";
 	}
	@PostMapping("/edit/edit")
	public String editFilm(@Valid @ModelAttribute("edit_film_attr") Film film,BindingResult result,
						   RedirectAttributes redirectAttrs) {

		if (film.getRegista() != null && film.getRegista().getId() != null)
			film.setRegista(registaService.caricaSingoloElemento(film.getRegista().getId()));

		if (result.hasErrors()) {
			redirectAttrs.addFlashAttribute("errorMessage", "Attenzione,son presenti errori di validazione");
			return "redirect:/film";
		}

 		try{
			filmService.aggiorna(film); ;
			redirectAttrs.addFlashAttribute("successMessage", "Operazione eseguita correttamente");
		}catch (RuntimeException e){
			redirectAttrs.addFlashAttribute("errorMessage", "Attenzione,il film non è stato modificato correttamente");
		}
		return "redirect:/film";
	}

	@GetMapping("delete/{idFilm}")
	public String deleteFilm(@PathVariable(required = true) Long idFilm, Model model) {
		model.addAttribute("delete_film_attr", filmService.caricaSingoloElementoEager(idFilm));
		return "film/delete";
	}
	@PostMapping("/delete/execute")
	public String deleteFilm(@ModelAttribute("delete_film_attr") Film film, RedirectAttributes redirectAttrs) {

		try{
			filmService.rimuovi(filmService.caricaSingoloElemento(film.getId())) ;
			redirectAttrs.addFlashAttribute("successMessage", "Operazione eseguita correttamente");
		}catch (RuntimeException e){
			redirectAttrs.addFlashAttribute("errorMessage", "Attenzione,il film non è stato modificato correttamente");
		}
		return "redirect:/film";
	}

}
