const cds = require('@sap/cds');
const moment = require('moment');

module.exports = class LogaliGroup extends cds.ApplicationService {

    init () {

        const {ProductsSet, ReviewsSet} = this.entities;

        //before
        //on
        //after


        this.before('NEW', ProductsSet.drafts, (req)=>{
            console.log("Estoy a punto de crear un nuevo registro");
            req.data.details??= {
                baseUnit: "EA",
                width: 0.00,
                height: 0.00,
                depth: 0.00,
                weight: 0.00,
                unitVolume: "CM",
                unitWeight: "KG"
            }
        });

        this.after('UPDATE', ProductsSet.drafts, async (req) =>{
            if (req.availability_code) {
                switch (req.availability_code) {
                    case 'InStock':             await this.updateCriticality(req, ProductsSet, 3); break;
                    case 'LowAvailability':     await this.updateCriticality(req, ProductsSet, 2); break;
                    case 'NotInStock':          await this.updateCriticality(req, ProductsSet, 1); break;
                }
            }
        });

        this.before('NEW', ReviewsSet.drafts, async (req)=>{
            req.data.creationDate = moment().format("YYYY-MM-DD");
        });

        return super.init();
    }

    async updateCriticality (req, entity, criticality) {
        return  await UPDATE.entity(entity.drafts).set({criticality: criticality}).where({ID: req.ID, product: req.product});
    }
}