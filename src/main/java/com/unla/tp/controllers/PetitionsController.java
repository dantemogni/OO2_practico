package com.unla.tp.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.unla.tp.controllers.helpers.ViewRouteHelper;
import com.unla.tp.models.Petition;
import com.unla.tp.services.IPetitionService;

@Controller
public class PetitionsController {
    @Autowired
    private IPetitionService petitionService;

    // REDIRIGE A LAS PETICIONES HECHAS
    @Secured("ROLE_ADMIN")
    @GetMapping("/manOrderNotes")
    public ModelAndView petitions() {

        ModelAndView mV = new ModelAndView(ViewRouteHelper.PETITIONS_LST);

        return mV;
    }

    // REDIRIGE A NUEVAS NOTAS DE PEDIDO
    @Secured("ROLE_PROFESOR")
    @GetMapping("/petitionNote")
    public ModelAndView newPetition() {

        ModelAndView mV = new ModelAndView(ViewRouteHelper.NEW_PETITION);
        mV.addObject("petition", new Petition());
        return mV;
    }

    @PostMapping("/petitionNote")
    public ModelAndView newNotePetition(@ModelAttribute("petition") Petition petitionModel) {

        ModelAndView mV = new ModelAndView(ViewRouteHelper.NEW_PETITION);

        petitionService.insert(petitionModel);
        mV.addObject("successMessage", "Petición creada");

        return mV;
    }

}
