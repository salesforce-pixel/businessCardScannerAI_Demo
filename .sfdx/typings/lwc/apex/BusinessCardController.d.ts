declare module "@salesforce/apex/BusinessCardController.extractFromCard" {
  export default function extractFromCard(param: {contentDocumentId: any}): Promise<any>;
}
declare module "@salesforce/apex/BusinessCardController.findLead" {
  export default function findLead(param: {email: any}): Promise<any>;
}
declare module "@salesforce/apex/BusinessCardController.createLead" {
  export default function createLead(param: {extractedJson: any}): Promise<any>;
}
declare module "@salesforce/apex/BusinessCardController.updateLead" {
  export default function updateLead(param: {extractedJson: any, existingLeadId: any}): Promise<any>;
}
