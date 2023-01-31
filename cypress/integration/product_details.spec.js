/// <reference types="cypress" />


describe('example to-do app', () => {

  it('visits the homepage', () => {
    cy.visit('http://localhost:3000/')
  });

  it("clicks on the product to go the product view page", () => {
    cy.get('article:nth-of-type(2)').click()
  });

})