/// <reference types="cypress" />


describe('example to-do app', () => {

  it('visits the homepage', () => {
    cy.visit('http://localhost:3000')
  });

  it("clicks on the product to go the product view page", () => {
    cy.get(".products .button_to .btn").first().click({force: true})
  })

  it("checks that cart now displays 1 once a product is added", () => {
    cy.get("a.nav-link").contains("My Cart").should("contain","1")
  })
});