describe('example to-do app', () => {
  beforeEach(() => {
       cy.visit('/')
  })
  it("navigates from the home page to the product detail page", () => {
    cy.get(".products article")
    .first()
    .click()
    cy.contains(".product-detail", "Add");

  });
});