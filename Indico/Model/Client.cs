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
    
    public partial class Client
    {
        public Client()
        {
            this.JobNames = new HashSet<JobName>();
        }
    
        public int ID { get; set; }
        public string Name { get; set; }
        public int Distributor { get; set; }
        public string Description { get; set; }
        public bool FOCPenalty { get; set; }
    
        public virtual Company Company { get; set; }
        public virtual ICollection<JobName> JobNames { get; set; }
    }
}
