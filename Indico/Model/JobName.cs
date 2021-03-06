//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Indico.Model
{
    using System;
    using System.Collections.Generic;
    
    public partial class JobName
    {
        public JobName()
        {
            this.ArtWorks = new HashSet<ArtWork>();
            this.DistributorClientAddresses = new HashSet<DistributorClientAddress>();
            this.Orders = new HashSet<Order>();
            this.Products = new HashSet<Product>();
            this.VisualLayouts = new HashSet<VisualLayout>();
        }
    
        public int ID { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string PostalCode { get; set; }
        public string Country { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public int Creator { get; set; }
        public System.DateTime CreatedDate { get; set; }
        public int Modifier { get; set; }
        public System.DateTime ModifiedDate { get; set; }
        public Nullable<int> Client { get; set; }
    
        public virtual ICollection<ArtWork> ArtWorks { get; set; }
        public virtual Client Client1 { get; set; }
        public virtual ICollection<DistributorClientAddress> DistributorClientAddresses { get; set; }
        public virtual User User { get; set; }
        public virtual User User1 { get; set; }
        public virtual ICollection<Order> Orders { get; set; }
        public virtual ICollection<Product> Products { get; set; }
        public virtual ICollection<VisualLayout> VisualLayouts { get; set; }
    }
}
